class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  get "/" do
    { message: "try /users, /comments, or /posts" }.to_json
  end

  #USERS
  get "/users" do
    users = User.all
    users.to_json
  end

  get "/users/:id" do
    user = User.find(params[:id])
    user.to_json
  end

  get "/usernames" do
    users = User.all.map do |user|
      user.user_name
    end
    users.to_json
  end

  get "/search-users/:name" do
    user = User.find_by(user_name: params[:name])
    user.to_json
  end

  post "/users" do
    user = User.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      user_name: params[:user_name],
      password: params[:password],
      profile_img: params[:profile_img]
    )
    user.to_json
  end

  patch "/users/:id" do
    user = User.find(params[:id])
    user.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      user_name: params[:user_name],
      password: params[:password],
      profile_img: params[:profile_img]
    )
    user.to_json
  end

  delete "/users/:id" do
    user = User.find(params[:id])
    user.destroy
    user.to_json
  end


  #POSTS
  get "/posts" do
    posts = Post.all
    posts.to_json(include: [:user, { comments: { include: :user } }])
  end

  get "/posts/:id" do
    post = Post.find(params[:id])
    post.to_json
  end

  post "/posts" do
    post = Post.create(
      content: params[:content],
      user_id: params[:user_id]
    )
    post.to_json
  end

  patch "/posts/:id" do
    post = Post.find(params[:id])
    post.update(
      content: params[:content],
      user_id: params[:user_id]
    )
    post.to_json
  end

  delete "/posts/:id" do
    post = Post.find(params[:id])
    post.destroy
    post.to_json 
  end

  #COMMENTS
  get "/comments" do
    comments = Comment.all
    comments.to_json
  end

  post "/comments" do
    comment = Comment.create(
      content: params[:content],
      user_id: params[:user_id],
      post_id: params[:post_id]
    )
    comment.to_json
  end

  patch "/comments/:id" do
    comment = Comment.find(params[:id])
    comment.update(
      content: params[:content],
      user_id: params[:user_id],
      post_id: params[:post_id]
    )
    comment.to_json
  end

  delete "/comments/:id" do
    comment = Comment.find(params[:id])
    comment.destroy
    comment.to_json
  end

end
