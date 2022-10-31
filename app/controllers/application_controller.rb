class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  #USERS
  get "/users" do
    users = User.all
    users.to_json
  end

  #POSTS
  get "/posts" do
    posts = Post.all
    posts.to_json
  end

  #COMMENTS
  get "/comments" do
    comments = Comment.all
    comments.to_json
  end

end
