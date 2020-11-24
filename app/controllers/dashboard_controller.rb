class DashboardController < ApplicationController
  def index
    @appointments = Appointment.all || nil
  end
end
