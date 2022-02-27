require 'bcrypt'

module Lock
  class CreatePasswordFileGenerator < Rails::Generators::Base
    argument :password, type: :string
    source_root File.expand_path("templates", __dir__)

    def create_password_file
      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      create_file "config/lock_password", password_hash
    end
  end
end
