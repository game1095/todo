class ListsController < ApplicationController
  before_action :authenticate_user!
  def index
    @lists = List.where(user_id: current_user.id).order('created_at DESC')
  end

  def new
    # @list = List.new
    @list = current_user.lists.build
  end

  def create
    # user = current_user.id
    # @list = List.new(list_params)
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to  lists_path
    else
      render 'new'
    end
  end


  private
    def list_params
      params.require(:list).permit(:title , :description  , :finishedDate)
    end

end
