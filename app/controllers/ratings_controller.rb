class RatingsController < ApplicationController
  # Returns all Ratings of specified Course and Professor in JSON
  def index
    ratings = Rating.where(course_id: params[:course_id])
      .where(professor_id: params[:professor_id])
      .all

    render json: ratings
  end

  # Creates or updates a Rating
  # Returns created or updated Rating
  def create
    rating = Rating.where(email: params[:email].downcase)
      .where(course_id: params[:course_id])
      .where(professor_id: params[:professor_id])
      .first_or_initialize

    rating.rating = params[:rating]
    rating.description = params[:description]
      
    if rating.save
      render json: rating
    else
      render :json => { :errors => rating.errors }, :status => 422
    end
  end

  # Specifies permitted Rating parameters
  private
    def rating_params
      params.require(:rating).permit(:email, :description, :course_id, :professor_id)
    end
end
