class DashboardController < ApplicationController
  def index
    if params[:doctor_id] && params[:doctor_id] != ""
      @doctors = Doctor.where id: params[:doctor_id] 
    else
      @doctors = Doctor.order(:name)
    end
  end
end
