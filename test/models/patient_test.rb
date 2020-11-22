require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  setup do
    @patient = Patient.new(name: "Maria do Carmo Ferraz", birth_date: "1965-05-10", cpf: "123.456.789.96")
  end

  test "should not valid without name attribute" do
    @patient.name = nil
    assert_not @patient.save
  end

  test "should not valid without birth_date attribute" do
    @patient.birth_date = nil
    assert_not @patient.save
  end

  test "should not valid without cpf attribute" do
    @patient.cpf = nil
    assert_not @patient.save
  end
end
