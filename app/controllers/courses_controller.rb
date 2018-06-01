class CoursesController < ApplicationController
  def show
    course = Course.includes(:professors).find(params[:id])

    render json: course.to_json(include: :professors)
  end

  def index
    courses = Course.includes(:professors).all

    render json: courses.to_json(include: :professors)
  end

  def create
    course = Course.includes(:professors).new(course_params)
    course.professor_ids=(params[:professors])

    if course.save
      render json: course.to_json(include: :professors)
    else
      render :json => { :errors => course.errors }, :status => 422
    end
  end

  def update
    course = Course.includes(:professors).find(params[:id])
    course.update!(course_params)
    
    course.professor_ids=(params[:professors])

    render json: course.to_json(include: :professors)
  end

  def destroy
    course = Course.includes(:professors).find(params[:id])
    course.destroy
    
    render :json => course
  end

  private
    def course_params
      params.require(:course).permit(:name, :description, :professors)
    end
end
