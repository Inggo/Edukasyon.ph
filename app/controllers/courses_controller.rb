class CoursesController < ApplicationController
  # Returns specified Course with associated Professors and Ratings in JSON
  def show
    course = Course.includes(:professors).includes(:ratings).find(params[:id])

    render json: course.to_json(include: [:professors, :ratings])
  end

  # Returns all Courses with associated Professors and Ratings in JSON
  def index
    courses = Course.includes(:professors).includes(:ratings).all

    render json: courses.to_json(include: [:professors, :ratings])
  end

  # Create a new Course from the request
  # Returns created Course with associated Professors in JSON
  def create
    course = Course.includes(:professors).new(course_params)
    course.professor_ids=(params[:professors])

    if course.save
      render json: course.to_json(include: :professors)
    else
      render :json => { :errors => course.errors }, :status => 422
    end
  end

  # Updates a Course from the request
  # Returns updated Course with associated Professors in JSON
  def update
    course = Course.includes(:professors).find(params[:id])
    course.update!(course_params)
    
    course.professor_ids=(params[:professors])

    render json: course.to_json(include: :professors)
  end

  # Deletes a Course from the request
  # Returns deleted Course with associated Professors in JSON
  def destroy
    course = Course.includes(:professors).find(params[:id])
    course.destroy
    
    render :json => course
  end

  # Specifies permitted Course parameters
  private
    def course_params
      params.require(:course).permit(:name, :description, :professors)
    end
end
