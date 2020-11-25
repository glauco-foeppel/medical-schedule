class Appointment < ApplicationRecord
  belongs_to :patient, class_name: "Patient", foreign_key: "patient_id"
  belongs_to :doctor, class_name: "Doctor", foreign_key: "doctor_id"

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :patient_id, presence: true
  validates :doctor_id, presence: true
  validates :starts_at, uniqueness: true
end
