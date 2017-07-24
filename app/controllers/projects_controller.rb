class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    puts "<<<<<<<<<<<<<<<<<<<<<<<<<<#{@project.id.inspect}"
    # @project = List.find(Project.find(params[:id]))
    @project = List.find(project_id: @project.id)
  end
end
