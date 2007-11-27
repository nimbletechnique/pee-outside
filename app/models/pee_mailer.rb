class PeeMailer < ActionMailer::Base

  # when someone submits a comment for an entry
  def entry_comment_submitted(entry, comment, sent_at = Time.now)
    @subject    = "Comment submitted for entry: #{entry.title}"
    @body       = {:entry=>entry, :comment=>comment}
    @recipients = 'peeoutside@lists.gluedtomyseat.com'
    @from       = ''
    @sent_on    = sent_at
    @headers    = {}
  end
  
  # when someone submits a comment for a news item
  def news_comment_submitted(newsitem, comment, sent_at = Time.now)
    @subject    = "Comment submitted for news item: #{newsitem.title}"
    @body       = {:newsitem=>newsitem, :comment=>comment}
    @recipients = 'peeoutside@lists.gluedtomyseat.com'
    @from       = ''
    @sent_on    = sent_at
    @headers    = {}
  end
  
  def signup_received(signup, sent_at = Time.now)
    @subject    = 'Signup received at peeoutside.org'
    @body       = {:signup=>signup}
    @recipients = 'peeoutside@lists.gluedtomyseat.com'
    @from       = ''
    @sent_on    = sent_at
    @headers    = {}
  end
  
  def upload_received(upload = nil, sent_at = Time.now)
    @subject    = "Pee Outside Upload Received"
    @body       = {}
    @recipients = 'peeoutside@lists.gluedtomyseat.com'
    @from       = ''
    @sent_on    = sent_at
    @headers    = {}
    if upload
      attachment upload.content_type do |a|
        a.filename = upload.name
        a.body = upload.data
      end
    end
  end
  
  def site_contact(site_contact, sent_at = Time.now)
    @subject    = 'Site feedback for peeoutside.org'
    @body       = {:site_contact=>site_contact}
    @recipients = 'peeoutside@lists.gluedtomyseat.com'
    @from       = ''
    @sent_on    = sent_at
    @headers    = {}
  end
  
  
end
