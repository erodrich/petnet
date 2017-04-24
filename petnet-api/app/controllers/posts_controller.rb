class PostsController < ApplicationController
  before_action :set_pet,   only: [:index, :show, :create, :update, :destroy]
  before_action :set_pet_post, only: [:show, :update, :destroy]

  # GET /todos/:todo_id/items
  def index
    json_response(@pet.post)
  end

  # GET /todos/:todo_id/items/:id
  def show
    json_response(@post)
  end

  # POST /todos/:todo_id/items
  def create
    #@pet.post.create!(post_params)
    @post = Post.new(post_params)
    @post.pet_id = @pet.id
    @post.save
    json_response(@pet, :created)
  end

  # PUT /todos/:todo_id/items/:id
  def update
    @post.update(post_params)
    head :no_content
  end

  # DELETE /todos/:todo_id/items/:id
  def destroy
    @post.destroy
    head :no_content
  end
  
  def search
    #@posts = Post.where(nil)
    @posts = Post.select('posts.id, posts.title, posts.content, pets.name').joins(:pet)
    @posts = @posts.active(true)
    @posts = @posts.animal(params[:animal]) if params[:animal].present?
    json_response(@posts)
  end

  private

  def post_params
    params.permit(:title, :content, :active)
  end

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_pet_post
    @post = @pet.post if @pet
  end
end
