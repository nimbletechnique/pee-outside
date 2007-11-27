class PeeController < ApplicationController
  
  before_filter :ensure_cookie
  
  def index
    @welcome_message = WelcomeMessage.find(:first)
    @news_items = Newsitem.find(:all, :order=>'newsitems.created desc', :limit=>1, :include=>:comments)
  end
  
  def rate_entry
    @entry = Entry.find params[:id]
    cookie = get_site_cookie
    
    rating_record = RatingRecord.find(:first, :conditions=>['entry_id = ? and cookie = ?', @entry.id, cookie])
    unless rating_record
      begin
        Entry.transaction do
          rating = params[:rating].to_i
          @entry.rating = @entry.rating * @entry.number_ratings + rating 
          @entry.number_ratings = @entry.number_ratings + 1
          @entry.rating = @entry.rating / @entry.number_ratings
          @entry.save

          RatingRecord.create(:entry=>@entry, :cookie=>cookie)
        end
      rescue
        @rating_error = "Could not save rating: #{$!}"
        logger.error @rating_error
      end
    else
      @rating_error = "You have already voted on this entry"
      # flash[:error] = 'You have already voted on this entry'
    end
    unless request.xhr?
      return redirect_to :action=>:photo, :id=>@entry if params[:back_to_entry]
      redirect_to :action=>:photos, :page=>params[:page]
    end
  end
  
  def contact_us
    if request.post?
      @site_contact = SiteContact.new(params[:site_contact])
      if @site_contact.save
        flash[:notice] = 'Thanks for your feedback!'
        PeeMailer.deliver_site_contact(@site_contact)
        redirect_to :action=>:index
      end
    end
  end
  
  def faq
    @faqs = Faq.find(:all, :order=>'position')
  end
  
  def privacy
  end
  
  def news
    @newsitem_pages, @newsitems = paginate(
      :newsitems,
      :order=>'newsitems.created desc',
      :include=>[:comments],
      :per_page=>4
    )
  end
  
  def newsitem
    @newsitem = Newsitem.find params[:id]
    @comments = Comment.find_for_newsitem @newsitem
  end
  
  def signup
    if request.post?
      @signup = Signup.new(params[:signup])
      if @signup.save
        # send the notification email
        PeeMailer.deliver_signup_received(@signup)

        flash[:notice] = 'Thank you for signing up!'
        redirect_to :action=>:index
      end
    end
  end
  
  # renders an upload
  def image
    @upload = Upload.find(params[:id], :include=>:entry)
    entry = @upload.entry
    response.headers['Last-Modified'] = @upload.created.httpdate
    if entry.approved?
      logger.debug "Http modified since: #{request.env["HTTP_IF_MODIFIED_SINCE"]}"
      minTime = Time.rfc2822(request.env["HTTP_IF_MODIFIED_SINCE"]) rescue nil
      logger.debug "Mintime is #{minTime}"
      if minTime and @upload.created <= minTime
        # use the cached version
        logger.debug "Instructing browser to use cache"
        render_text '', '304 Not Modified'
      else
        logger.debug "Sending image data"
        send_data(
          @upload.data, 
          :filename=>@upload.name, 
          :type=>@upload.content_type,
          :disposition=>'inline'
        )
      end
    end
  end
  
  def photo
    cookie = get_site_cookie
    @entry = Entry.find(params[:id])
    @comments = Comment.find_for_entry(@entry)
    @records = records_for_entries([@entry])
    
    logger.debug "Got records for entry with id #{@entry.id}: \n#{@records.inspect}"
    
  end
  
  def photos
    cookie = get_site_cookie
    # get the entries
    @entry_pages, @entries = paginate(
      :entries,
      :conditions=>['entries.approved = true'],
      :order=>'entries.created desc',
      :include=>[:comments,:small_thumbnail],
      :per_page=>4
    )
    
    # get the voting records for these entries
    @records = records_for_entries(@entries)
  end
  
  def show_news_comment_form
    @comment = new_comment_using_cookies
    @newsitem = Newsitem.find params[:id]
    render :partial=>'news_comment_form' unless request.xhr?
  end
  
  def show_entry_comment_form
    @comment = new_comment_using_cookies
    @entry = Entry.find(params[:id])
    render :partial=>'entry_comment_form' unless request.xhr?
  end
  
  def add_news_comment
    if request.post?
      @newsitem = Newsitem.find params[:id]
      @comment = Comment.new params[:comment]
      save_name_and_location_cookies_for_comment @comment
      
      @comment.newsitem = @newsitem
      if @comment.save
        #notify
        PeeMailer.deliver_news_comment_submitted(@newsitem, @comment)
        @added_comment = @comment
      end
      return redirect_to(:action=>:newsitem, :id=>@newsitem) unless request.xhr?

      @comments = Comment.find_for_newsitem @newsitem
    end
  end
  
  def add_entry_comment
    if request.post?
      @entry = Entry.find(params[:id])
      @comment = Comment.new(params[:comment])
      save_name_and_location_cookies_for_comment @comment
      
      @comment.entry = @entry
      if @comment.save
        # send the notification email
        PeeMailer.deliver_entry_comment_submitted(@entry, @comment)
        @added_comment = @comment
      end
      return redirect_to(:action=>:photo, :id=>@entry) unless request.xhr?
      @comments = Comment.find_for_entry @entry
    end
  end

  private

  def new_comment_using_cookies
    @comment = Comment.new
    @comment.name = cookies[:name]
    @comment.location = cookies[:location]
    @comment
  end

  def save_name_and_location_cookies_for_comment(comment)
    return unless comment
    cookies[:name] = comment.name
    cookies[:location] = comment.location
  end
  
  def records_for_entries(entries)
    cookie = get_site_cookie
    # get the voting records for these entries
    entry_ids = entries.map { |entry| entry.id }
    RatingRecord.find(:all, 
      :include=>:entry, 
      :conditions=>["entries.id IN (" + entry_ids.join(",") +  ") AND rating_records.cookie = ?", cookie])
  end
  
  def ensure_cookie
    logger.debug 'Ensuring cookie'
    cookie = get_site_cookie
    unless cookie
      value = Time.now.to_s + rand.to_s
      logger.debug "Created site cookie: #{value}"
      cookies[:site] = {
        :value=>value,
        :expires=>365.days.from_now
      }
    end
    get_site_cookie
  end

  def get_site_cookie
    cookies[:site]
  end
  
end
