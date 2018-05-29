class CoursesController < ApplicationController
  def index
    @courses = Course.all
    render :json => @courses
  end

  def create
    @course = Course.new(params[:course])
     
    if @course.save
      render :json => @course
    else
      render json: {
        error: true,
        message: 'Unable to create course'
      }
    end
  end
end
