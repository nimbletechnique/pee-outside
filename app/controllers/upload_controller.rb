class UploadController < ApplicationController
  
  
  def index
    @upload = Upload.new
    @entry = Entry.new
  end

  # saves both an entry and an upload  
  def save_upload
    @entry = Entry.new(params[:entry])

    @upload = small_thumb = nil

    # resize the upload into three images
    begin
      @upload = Upload.new(params[:upload])
      @upload.data = Resize.resize_and_watermark(@upload.data, 1024, 768)

      small_thumb = Upload.copy_from(@upload)
      small_thumb.data = Resize.resize_and_watermark(small_thumb.data, 160, 120)
    rescue
      logger.error "Could not create thumbnail: #{$!}"
      return redirect_to :action=>:index
    end

    begin
      Entry.transaction do
        logger.info "Saving entry"
        if @entry.save! 
          logger.info "Entry saved"
          @entry = Entry.find_by_id(@entry.id)
          logger.info "Refetched entry: #{@entry}"
          
          logger.info "Setting entry for @upload: #{@upload}"
          @upload.entry = @entry
          logger.info "Setting entry for small thumb: #{small_thumb}"
          small_thumb.entry = @entry

          logger.info "Saving upload"
          if @upload.save!
            
            logger.info "Saving small thumb"
            if small_thumb.save!
              @entry.upload = @upload
              @entry.small_thumbnail= small_thumb
              @entry.save!

              # send the notification email
              PeeMailer.deliver_upload_received(@upload)

              flash[:notice] = 'Thank you for your upload. After it is approved, it will be available on the live site'
              return redirect_to :action=>:index
            end
          end
        end
      end
    rescue
      msg = "Could not save something: #{$!}"
      logger.error msg
      
      flash[:error] = msg
      return redirect_to :action=>:index
    end

  end
  
  
  
end
