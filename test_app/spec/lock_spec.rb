require 'spec_helper'
require 'systemu'
require 'lock'

def delete_lockdown_file
  FileUtils.rm("#{Rails.root}/config/lock_password") if File.exists? "#{Rails.root}/config/lock_password"
end

def get_ac(controller_name,action_name)
  ApplicationController.class_eval{attr_accessor :controller_name, :action_name}
  ac = ApplicationController.new
  ac.controller_name = controller_name
  ac.action_name = action_name
  ac
end

describe "Lock" do
  it "should generate a password file if none exists" do
    delete_lockdown_file
    output = systemu("rails g lock:create_password_file ieatpasswordslikeyouforbreakfast")[1]
    output.match(/create.*config\/lock_password/).should_not eq nil
    IO.read("#{Rails.root}/config/lock_password").size.to_i.should eq 60
    delete_lockdown_file
  end
  
  it "should generate ask you to overwrite existing password file" do
    delete_lockdown_file
    File.open("#{Rails.root}/config/lock_password", 'w') {|f| f.write("abc") } unless File.exists? "#{Rails.root}/config/lock_password"
    output = systemu("rails g lock:create_password_file ieatpasswordslikeyouforbreakfast")[1]
    output.match(/conflict/).should_not eq nil
    delete_lockdown_file
  end
  
  it "should match passwords" do
    copy_password_template_file
    Lock.passwords_match?("mypassword").should be true
    Lock.passwords_match?("mypasswor2").should be false
  end

  it "should make methods available in the app controller" do
    ApplicationController.instance_methods.include?(:lock_filter).should be true
    ApplicationController.instance_methods.include?(:locked_action?).should be true    
  end
  
  it "should return false for any lock controller actions" do
    ac = get_ac("lock","login")
    ac.locked_action?([]).should be false
  end
  
  it "should return true for any controller (except lock) if blank actions array is specified" do
    ac = get_ac("not_lock","login")
    ac.locked_action?([]).should be true
  end
  
  it "should return true for all actions if only controller is specified" do
    ac = get_ac("widgets","new")
    ac.locked_action?(["widgets"]).should be true
    ac = get_ac("widgets","index")
    ac.locked_action?(["widgets"]).should be true
  end
  
  it "should return true for specific actions, but not others" do
    ac = get_ac("widgets","new")
    ac.locked_action?(["widgets#new"]).should be true
    ac = get_ac("widgets","index")
    ac.locked_action?(["widgets#new"]).should be false    
  end
end