require 'yaml'

class AdminController < ApplicationController
  
  before_filter :authorize, :except=>:login
  
  def delete_comment
    comment = Comment.find_by_id(params[:id])
    
    newsitem = comment.newsitem
    entry = comment.entry
    
    comment.destroy
    
    redirect_to :controller=>:pee, :action=>:newsitem, :id=>newsitem if newsitem
    redirect_to :controller=>:pee, :action=>:photo, :id=>entry if entry
  end
  
  def welcome_message
    @welcome_message = WelcomeMessage.find :first
    if request.post?
      if @welcome_message.update_attributes(params[:welcome_message])
        flash[:notice] = 'Message updated'
        redirect_to :action=>:welcome_message
      end
    end
  end
  
  def index
    @entries = Entry.find(:all, :conditions=>"approved = false", :order=>"created desc")
  end

  def news
    @newsitems = Newsitem.find(:all, :order=>"created desc")
  end

  def newsitem
    @newsitem = Newsitem.find(params[:id])
  end
  
  def faqs
    @faqs = Faq.find(:all, :order=>'position')
  end
  
  def faq
    @faq = Faq.find(params[:id])
  end

  def create_faq
    if request.post?
      if params[:id]
        # update the existing faq
        @faq = Faq.find(params[:id])
        if @faq.update_attributes(params[:faq])
          flash[:notice] = "FAQ updated"
          redirect_to :action=>:faq, :id=>@faq
        end
      else
        # create a new faq
        @faq = Faq.new(params[:faq])
        if @faq.save
          flash[:notice] = "FAQ created"
          redirect_to :action=>:faq, :id=>@faq
        end
      end
    else
      # load the form, dummy
      @faq = Faq.find(params[:id]) if params[:id]
    end
  end

  def create_news
    if request.post?
      if params[:id]
        @newsitem = Newsitem.find(params[:id])
        if @newsitem.update_attributes(params[:newsitem])
          flash[:notice] = "News item updated"
          redirect_to :action=>:newsitem, :id=>@newsitem
        end
      else
        @newsitem = Newsitem.new(params[:newsitem])
        if @newsitem.save
          flash[:notice] = "News item created"
          redirect_to :action=>:newsitem, :id=>@newsitem
        end
      end
    else
      # we are in a get
      @newsitem = Newsitem.find(params[:id]) if params[:id]
    end
  end

  def delete_faq
    @faq = Faq.find(params[:id])
    @faq.destroy
    flash[:notice] = 'FAQ deleted'
    redirect_to :action=>:faqs
  end

  def delete_news
    @newsitem = Newsitem.find(params[:id])
    @newsitem.destroy
    flash[:notice] = 'News item deleted'
    redirect_to :action=>:news
  end

  # renders an upload
  def image
    @upload = Upload.find(params[:id])
    send_data(@upload.data, :filename=>@upload.name, :type=>@upload.content_type,
      :disposition=>"inline")
  end
  
  def signups
    @signups = Signup.find(:all, :order=>"created DESC")
  end
  
  def reject
    @entry = Entry.find(params[:id])
    @entry.upload.destroy if @entry.upload
    @entry.small_thumbnail.destroy if @entry.small_thumbnail
    @entry.medium_thumbnail.destroy if @entry.medium_thumbnail
    @entry.destroy
    redirect_to :action=>:index
  end
  
  def approve
    @entry = Entry.find(params[:id])
    @entry.approved = true
    @entry.save
    redirect_to :action=>:index
  end
  
  def login
    if request.post?
      if credentials_match?
        session[:user] = params[:username]
        redirect_to :controller=>:admin, :action=>:index
      end
    end
  end
  
  def logout
    session[:user] = nil
    redirect_to :controller=>:admin
  end

  private
  
  def credentials_match?
    ["username", "password"].all? { |x| credentials[x] == params[x] }
  end
  
  def credentials
    @credentials ||= YAML.load_file(File.expand_path("config/admin.yml"), RAILS_ROOT)
  end
  
  
  
end
