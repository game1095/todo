class ListsController < ApplicationController
  before_action :authenticate_user!
  def index
    @lists = List.where(user_id: current_user.id).order('created_at DESC')
  end

  def new
    @list = current_user.lists.build
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to  lists_path
    else
      render 'new'
    end
  end

  def destroy
    @list = List.find(params[:id])
    if @list.destroy
      redirect_to lists_path
    else
      render lists_path
    end
  end

  private
    def list_params
      params.require(:list).permit(:title , :description  , :finishedDate)
    end
end
