class Patient < ApplicationRecord

    has_many :appointments, dependent: :destroy

    validates :name, presence: true
    validates :birth_date, presence: true
    validates :cpf, presence: true
end
