class ProfessorsController < ApplicationController
  def show
    professor = Professor.includes(:courses).includes(:ratings).find(params[:id])

    render json: professor.to_json(include: [:courses, :ratings])
  end

  def index
    professors = Professor.includes(:courses).all

    render json: professors.to_json(include: :courses)
  end

  def create
    professor = Professor.new(professor_params)
     
    if professor.save
      render json: professor.to_json(include: :courses)
    else
      render :json => { :errors => professor.errors }, :status => 422
    end
  end

  def update
    professor = Professor.find(params[:id])
    professor.update!(professor_params)

    render json: professor.to_json(include: :courses)
  end

  def destroy
    professor = Professor.find(params[:id])
    professor.destroy
    
    render :json => professor
  end

  private
    def professor_params
      params.require(:professor).permit(:name, :bio)
    end
end
