class RatingController < ApplicationController
  def index
    courses = Course.includes(:professors).all

    render json: courses.to_json(include: :professors)
  end

  def create
    rating = Rating.where(email: params[:email])
      .where(course_id: params[:course_id])
      .where(professor_id: params[:professor_id])
      .first_or_initialize(locked: false)
    
    rating.description = params[:description]
      
    if course.save
      render json: rating
    else
      render :json => { :errors => rating.errors }, :status => 422
    end
  end

  private
    def course_params
      params.require(:rating).permit(:email, :description, :course_id, :professor_id)
    end
end
