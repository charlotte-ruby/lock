# frozen_string_literal: true

def get_ac(controller_name, action_name)
  ApplicationController.class_eval { attr_accessor :controller_name, :action_name }

  ac = ApplicationController.new
  ac.controller_name = controller_name
  ac.action_name = action_name
  ac
end

RSpec.describe Lock do
  it "has a version number" do
    expect(Lock::VERSION).not_to be nil
  end

  it "should match passwords" do
    copy_password_template_file

    expect(Lock.passwords_match?("mypassword")).to be_truthy
    expect(Lock.passwords_match?("mypasswor2")).to be(false)
  end

  it "should make methods available in the app controller" do
    expect(ApplicationController.instance_methods).to include(:lock_filter)
    expect(ApplicationController.instance_methods).to include(:locked_action?)
  end

  it "should return false for any lock controller actions" do
    ac = get_ac("lock", "login")

    expect(ac.locked_action?([])).to be(false)
  end

  it "should return true for any controller (except lock) if blank actions array is specified" do
    ac = get_ac("not_lock", "login")

    expect(ac.locked_action?([])).to be(true)
  end

  it "should return true for all actions if only controller is specified" do
    ac = get_ac("widgets", "new")

    expect(ac.locked_action?(["widgets"])).to be(true)

    ac = get_ac("widgets", "index")

    expect(ac.locked_action?(["widgets"])).to be(true)
  end

  it "should return true for specific actions, but not others" do
    ac = get_ac("widgets", "new")

    expect(ac.locked_action?(["widgets#new"])).to be(true)

    ac = get_ac("widgets", "index")

    expect(ac.locked_action?(["widgets#new"])).to be(false)
  end
end
