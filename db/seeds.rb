# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

Faker::Config.locale = 'pt-BR'

# Create Doctor
puts "Criando Medicos"
(1..10).each{
    Doctor.create(name: Faker::Name.name_with_middle, crm: Faker::Number.number(digits: 6), crm_uf: Faker::Address.state_abbr)
}

# Create Patient
puts "Criando Pacientes"
(1..50).each{
    cpf = Faker::Number.number(digits: 11).to_s.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')
    Patient.create(name: Faker::Name.name_with_middle, birth_date: Faker::Date.birthday(min_age: 1, max_age: 100), cpf: cpf)
}

# Create Appointment
puts "Criando Agendamentos"
current_datetime = DateTime.now.utc.change({hour: 9, minute: 0}) - 3.days
(1..60).each do |i|
    puts "Criando regitro #{i}"
    current_datetime = current_datetime.hour == 12 ? current_datetime.change({hour: 13, minute: 0}) : current_datetime
    starts_at = current_datetime
    ends_at = current_datetime + 30.minutes
    doctor = Doctor.order('RANDOM()').first
    patient = Patient.order('RANDOM()').first
    Appointment.create(starts_at: starts_at, ends_at: ends_at, patient_id: patient.id, doctor_id: doctor.id)
    if i%16 == 0
        current_datetime = current_datetime.next_day.change({hour: 9, minute: 0})
    else
        current_datetime = ends_at
    end
end