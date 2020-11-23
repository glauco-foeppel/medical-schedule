require 'test_helper'

class DoctorTest < ActiveSupport::TestCase
  setup do
    @doctor = Doctor.new(name: "Carlos Tadeu Ortega", crm: "999888", crm_uf: "RJ")
  end

  test "should not valid without name attribute" do
    @doctor.name = nil
    assert_not @doctor.save
  end

  test "should not valid without crm attribute" do
    @doctor.crm = nil
    assert_not @doctor.save
  end

  test "should not valid without crm_uf attribute" do
    @doctor.crm_uf = nil
    assert_not @doctor.valid?
  end

  test "should not valid with crm and crm_uf exist" do
    duplicate = Doctor.new name: @doctor.name, crm: @doctor.crm, crm_uf: @doctor.crm_uf
    @doctor.save
    assert_not duplicate.save
  end
end
