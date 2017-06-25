class ListsController < ApplicationController
  before_action :authenticate_user!
  def index
    @lists = List.where(user_id: current_user.id , status:nil).order('created_at DESC')
    @complete_list = List.where(user_id: current_user.id , status: "completed")
    @count = List.where(user_id: current_user.id , status: nil).count
    @complete_count = List.where(user_id: current_user.id , status: 'completed').count
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

  def complete
    @list = List.find(params[:list_id]).update(status: "completed")
    redirect_to lists_path
  end

  def all_del_completed
    List.where(user_id: current_user.id , status: "completed").delete_all

    redirect_to lists_path
  end

  def show
    @list = List.find(params[:id])
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
