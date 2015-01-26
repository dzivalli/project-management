class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
    render layout: false
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end
end
