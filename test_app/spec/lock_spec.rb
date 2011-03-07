require 'spec_helper'
require 'systemu'
require 'lock'

def delete_lockdown_file
  FileUtils.rm("#{Rails.root}/config/lock_password") if File.exists? "#{Rails.root}/config/lock_password"
end

describe "Lock" do

=begin
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
=end
  
  it "should match passwords" do
    copy_password_template_file
    Lock.passwords_match?("mypassword").should be true
    Lock.passwords_match?("mypasswor2").should be false
  end
end