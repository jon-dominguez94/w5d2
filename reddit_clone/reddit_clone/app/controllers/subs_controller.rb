class SubsController < ApplicationController
  
  before_action :require_login
  before_action :ensure_moderator, only: [:edit, :update]
  
  def ensure_moderator
    @sub = Sub.find(params[:id])
    redirect_to sub_url(@sub) unless @sub.user_id == current_user.id    
  end
  
  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = current_user.subs.find(params[:id])
    # Test for empty sub
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
