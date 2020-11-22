json.extract! patient, :id, :name, :birth_date, :cpf, :created_at, :updated_at
json.url patient_url(patient, format: :json)
