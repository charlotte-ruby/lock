<<<<<<< HEAD
# frozen_string_literal: true

require "bcrypt"
require "lock/engine"
require "lock/railtie"

module Lock
  def self.passwords_match?(password)
    hashed_combo = IO.read("#{Rails.root}/config/lock_password")
    salt = hashed_combo[0, 29]
    hashed_combo == BCrypt::Engine.hash_secret(password, salt)
  rescue StandardError
    false
  end
end
=======
LOCK_PATH = File.dirname(__FILE__) + "/lock"
require "#{LOCK_PATH}/engine.rb"
require "bcrypt"

module Lock
  def self.passwords_match?(password)
    begin
      hashed_combo = IO.read("#{Rails.root}/config/lock_password")
    rescue
      return false
    end
    salt = hashed_combo[0,29]
    hashed_combo==BCrypt::Engine.hash_secret(password, salt)
  end
end
>>>>>>> master
