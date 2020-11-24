class DashboardController < ApplicationController
  def index
    
    if params[:starts_at] && params[:starts_at].present?
      starts_at = params[:starts_at].to_datetime
    else
      starts_at = DateTime.now - 7.days
    end
        
    if params[:ends_at] && params[:ends_at].present?
      ends_at = params[:ends_at].to_datetime
    else
      ends_at = DateTime.now - 7.days
    end
    
    if params[:doctor_id] && params[:doctor_id].present?
      @Doctors = Doctor.where(id: params[:doctor_id]).order(:name)
    else
      @Doctors = Doctor.order(:name)
    end

    @doctor_data = []
    @Doctors.each do |doctor|
      @doctor_data << {
        name: doctor.name, 
        total_appointment: doctor.appointments.where(starts_at: starts_at..ends_at).size, 
        total_patient: doctor.appointments.where(starts_at: starts_at..ends_at).distinct(:patient_id).count
      }
    end
  end
end
