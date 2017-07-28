class ListsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user , only: [:show , :edit , :destroy]

  def index
    @project = Project.find(params[:project_id])
    @lists = List.where(user_id: current_user.id , deleted_at:nil , status: 'incompleted' , project_id: @project).order('priority_id ASC').includes(:priority)
    @count = List.where(user_id: current_user.id , status: 'incompleted' , project_id: @project).count
    @complete_list = List.only_deleted.where(user_id: current_user.id , status: 'completed' , project_id: @project)
    @complete_count = List.only_deleted.where(user_id: current_user.id , status: 'completed' , project_id: @project).count
  end

  def new
    @list = current_user.lists.build
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @list = current_user.lists.build(list_params)
    if @list.save && @project.save
      redirect_to  project_lists_path
    else
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to project_lists_path
    else
      render 'edit'
    end
  end

  def complete
    @project = Project.find(params[:project_id])
    @list = List.find(params[:list_id]).destroy.update(status: 'completed')
    redirect_to project_lists_path
  end

  def all_del_completed
    @project = Project.find(params[:project_id])
    List.only_deleted.where(user_id: current_user.id , status: "completed").delete_all

    redirect_to project_lists_path
  end

  def del_completed
    @project = Project.find(params[:project_id])
    @list = List.only_deleted.find(params[:list_id])
    if @list.really_destroy!
      redirect_to project_lists_path
    end
  end

  def completed_restore
    @project = Project.find(params[:project_id])
    @list = List.only_deleted.find(params[:list_id]).update(status: 'incompleted' , deleted_at: nil)
    redirect_to project_lists_path
  end

  def show
    @list = List.find(params[:id])
  end

  def destroy
    @list = List.find(params[:id])
    if @list.really_destroy!
      redirect_to project_lists_path
    else
      render project_lists_path
    end
  end

  private
    def list_params
      params.require(:list).permit(:title , :description , :startdate  , :dateline , :priority_id , :priorities_id , :project_id)
    end
end

def correct_user
  @lists = current_user.lists.find_by(id: params[:id])
  redirect_to project_lists_path if @lists.nil?
end
