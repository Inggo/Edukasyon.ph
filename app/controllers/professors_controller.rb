class ProfessorsController < ApplicationController
  # Returns specified Professors with associated Courses and Ratings in JSON
  def show
    professor = Professor.includes(:courses).includes(:ratings).find(params[:id])

    render json: professor.to_json(include: [:courses, :ratings])
  end

  # Returns specified Professors with associated Courses in JSON
  def index
    professors = Professor.includes(:courses).all

    render json: professors.to_json(include: :courses)
  end

  # Create a new Professor from the request
  # Returns created Professor with associated Courses in JSON
  def create
    professor = Professor.new(professor_params)
     
    if professor.save
      render json: professor.to_json(include: :courses)
    else
      render :json => { :errors => professor.errors }, :status => 422
    end
  end

  # Updates a Professor from the request
  # Returns updated Professor with associated Courses in JSON
  def update
    professor = Professor.find(params[:id])
    professor.update!(professor_params)

    render json: professor.to_json(include: :courses)
  end

  # Deletes a Professor from the request
  # Returns updated Professor with associated Courses in JSON
  def destroy
    professor = Professor.find(params[:id])
    professor.destroy
    
    render :json => professor
  end

  # Specifies permitted Professor parameters
  private
    def professor_params
      params.require(:professor).permit(:name, :bio)
    end
end
