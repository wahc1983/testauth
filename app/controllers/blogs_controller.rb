
class BlogsController < ApplicationController
  before_filter :authenticate_user!
  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.search(params[:search]).page(params[:page]).per(2)
      respond_to do |format|
      format.html { # index.html.erb
        if ( request.xhr? )
          render( { :partial => 'blogs/search', :layout => false } )
          return
        end
      }
      format.json { render json: @blogs }
    end
  end
  # GET /blogs/1
  # GET /blogs/1.json
  def show
Rails.logger.debug( 'inside show' )
    #@comments = Comment.all
    @blog = Blog.find(params[:id])
    @comments = @blog.comments.search(params[:searchC])
    @comments = @comments.page(params[:page]).per(3)
    #Comment.where(:blog_id => params[:id])
    #@user_post = User.where({:id => @blog.user_id}).first
    #@user_post = @blog.user
    @ulr_img = @blog.picture_url(:thumb_1).to_s
      respond_to do |format|
      format.html { # show.html.erb
        if ( request.xhr? )
          render( { :partial => 'comments/searchComment', :layout => false } )
          return
        end
      }
      format.json { render json: @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.json
  def new
    @blog = Blog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
  end

  # POST /blogs
  # POST /blogs.json
  def create
    #@blog = Blog.new(params[:blog])
    @blog = current_user.blogs.create(params[:blog])
 
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.json
  def update
    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
      flash[:notice] = "The blog was successfully destroyed"
    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end
end
