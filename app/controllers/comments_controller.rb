class CommentsController < ApplicationController
 before_filter :authenticate_user!
  # GET /comments
  # GET /comments.json
  def index
    @blog = Blog.find(params[:blog_id])
    @comments = @blog.comments.search(params[:searchC])
    @comments = @comments.page(params[:page]).per(3)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @blog = Blog.find(params[:blog_id])
  end

  # POST /comments
  # POST /comments.json
  def create
    #@comment = Comment.new(params[:comment])
     @blog = Blog.find(params[:blog_id])
     @comment = @blog.comments.create(params[:comment])
     #@comment = current_user.comments.create(params[:comment])
     @comment.user = current_user
     #@comment.blog_id = @blog.id
 
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @blog, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to blog_path(@comment.blog_id), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to blog_path( @comment.blog_id) }
      format.json { head :no_content }
    end
  end
end
