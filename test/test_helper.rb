# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Add more helper methods to be used by all tests here...
  end
end

module ActionDispatch
  class IntegrationTest
    include FactoryBot::Syntax::Methods

    def sign_in(user)
      get '/auth/developer/callback', params: { email: user.email }
    end
  end
end
