# frozen_string_literal: true

require "spec_helper"
require "systemu"
require "lock"

RSpec.describe Lock do
  before(:each) do
    delete_lockdown_file
    Dir.chdir(File.expand_path("dummy", __dir__))
  end

  let(:lock_file) { File.expand_path("#{Rails.root}/config/lock_password") }

  it "should generate a password file if none exists" do
    output = systemu("rails g lock:create_password_file ieatpasswordslikeyouforbreakfast")[1]
    result = output.match(%r{create.*config/lock_password})

    expect(result).not_to eq(nil)
    expect(IO.read(lock_file).size.to_i).to eq(60)
  end

  it "should generate ask you to overwrite existing password file" do
    unless File.exist? "#{Rails.root}/config/lock_password"
      File.open("#{Rails.root}/config/lock_password", "w") do |f|
        f.write("abc")
      end
    end

    Dir.chdir(File.expand_path("dummy", __dir__))

    output = systemu("rails g lock:create_password_file ieatpasswordslikeyouforbreakfast")[1]
    result = output.match(/conflict/)

    expect(result).not_to eq(nil)
  end
end
