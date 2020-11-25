class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  skip_before_action :set_appointment, only: [:schedule]

  # GET /appointments
  # GET /appointments.json
  def index
    # @appointments = Appointment.order("starts_at DESC")
    redirect_to new_appointment_path
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    if params[:date] && params[:date].present?
      date_filter = params[:date].to_datetime
    else
      date_filter = DateTime.now
    end

    @appointments = {}
    @appointments[:data] = []
    @appointments[:date_filter] = date_filter.strftime("%Y-%m-%d")
    appointment = Appointment.where("strftime('%Y-%m-%d', starts_at) = ?", @appointments[:date_filter])
    
    range_hours(date_filter).each do |h|
      app_data = nil
      appointment.each do |app|
        if h.strftime("%H:%M") == app.starts_at.strftime("%H:%M")
          app_data = app
        end
      end
      @appointments[:data] << {date: h, data: app_data}
    end

    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.starts_at != nil
      @appointment.ends_at = @appointment.starts_at + 30.minutes
    end
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to new_appointment_path, notice: 'Agendamento realizado.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :schedule }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to new_appointment_path, notice: 'Agendamento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to new_appointment_path, notice: 'Agendamento deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def schedule
    @appointment = Appointment.new(starts_at: params[:date])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:starts_at, :ends_at, :patient_id, :doctor_id)
    end

    def range_hours(date)
      range_hours = []
      range_date = date.utc.change({hour: 9, minute: 0})
      (1..17).each do |num|
          range_hours << range_date
          range_date.strftime("%H:%M").to_s == "11:30" ? range_date = range_date + 90.minutes : range_date = range_date + 30.minutes
      end
      range_hours
  end
end
