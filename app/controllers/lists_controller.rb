class ListsController < ApplicationController

  before_action :authenticate_user! , except: [:index , :show]
  before_action :correct_user , only: [:show]

  def index
    @lists = List.where(user_id: current_user.id , deleted_at:nil , status: 'incompleted').order('priority_id ASC').includes(:priority)
    @count = List.where(user_id: current_user.id , status: 'incompleted').count
    @complete_list = List.only_deleted.where(user_id: current_user.id , status: 'completed')
    @complete_count = List.only_deleted.where(user_id: current_user.id , status: 'completed').count
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

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to lists_path
    else
      render 'edit'
    end
  end

  def complete
    @list = List.find(params[:list_id]).destroy.update(status: 'completed')
    redirect_to lists_path
  end

  def all_del_completed
    List.only_deleted.where(user_id: current_user.id , status: "completed").delete_all

    redirect_to lists_path
  end

  def del_completed
    @list = List.only_deleted.find(params[:list_id])
    if @list.really_destroy!
      redirect_to lists_path
    end
  end

  def completed_restore
    @list = List.only_deleted.find(params[:list_id]).update(status: 'incompleted' , deleted_at: nil)
    redirect_to lists_path
  end

  def show
    @list = List.find(params[:id])
  end

  def destroy
    @list = List.find(params[:id])
    if @list.really_destroy!
      redirect_to lists_path
    else
      render lists_path
    end
  end

  private
    def list_params
      params.require(:list).permit(:title , :description , :startdate  , :dateline , :priority_id , :priorities_id)
    end
end

def correct_user
  @lists = current_user.lists.find_by(id: params[:id])
  redirect_to lists_path if @lists.nil?
end
