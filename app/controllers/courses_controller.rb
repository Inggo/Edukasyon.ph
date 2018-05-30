class CoursesController < ApplicationController
  def index
    @courses = Course.all
    render :json => @courses
  end

  def create
    @course = Course.new(article_params)
     
    if @course.save
      render :json => @course
    else
      render :json => { :errors => @course.errors }, :status => 422
    end
  end

  private
    def article_params
      params.require(:course).permit(:name, :description)
    end
end
