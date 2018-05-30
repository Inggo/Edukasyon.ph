class CoursesController < ApplicationController
  def show
    @course = Course.find(params[:id])

    render :json => @course
  end

  def index
    @courses = Course.all
    render :json => @courses
  end

  def create
    @course = Course.new(course_params)
     
    if @course.save
      render :json => @course
    else
      render :json => { :errors => @course.errors }, :status => 422
    end
  end

  def update
    @course = Course.find(params[:id])
    @course.update!(course_params)

    render :json => @course
  end

  private
    def course_params
      params.require(:course).permit(:name, :description)
    end
end
