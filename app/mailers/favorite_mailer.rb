class FavoriteMailer < ApplicationMailer
  default from: 'syhoung1@gmail.com'
  
  def new_comment(user, post, comment)
    
    headers["Message-ID"] = "<comments/#{comment.id}@rocky-falls.example"
    headers["In-reply-to"] = "<post/#{post.id}@rocky-falls.example"
    headers["References"] = "<post/#{post.id}@rocky-falls.example"
    
    @user = user
    @post = post
    @comment = comment
    
    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
