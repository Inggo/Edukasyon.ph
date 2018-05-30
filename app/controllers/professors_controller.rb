class ProfessorsController < ApplicationController
  def show
    professor = Professor.find(params[:id])

    render :json => professor
  end

  def index
    professors = Professor.all
    render :json => professors
  end

  def create
    professor = Professor.new(professor_params)
     
    if professor.save
      render :json => professor
    else
      render :json => { :errors => professor.errors }, :status => 422
    end
  end

  def update
    professor = Professor.find(params[:id])
    professor.update!(professor_params)

    render :json => professor
  end

  def destroy
    professor = Professor.find(params[:id])
    professor.destroy
    
    render :json => professor
  end

  private
    def professor_params
      params.require(:Professor).permit(:name, :description)
    end
end
