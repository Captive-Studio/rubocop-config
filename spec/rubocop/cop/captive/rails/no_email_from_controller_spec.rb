# frozen_string_literal: true

require 'spec_helper'

describe RuboCop::Cop::Captive::Rails::NoEmailFromController do
  subject(:cop) { described_class.new }

  it 'registers an offense when sending email from a controller with deliver_now' do
    expect_offense(<<~RUBY)
      class UsersController < ApplicationController
        def send_email
          UserMailer.welcome_email.deliver_now
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Captive/Rails/NoEmailFromController: Do not send emails from controllers. Because it doesn\'t follow the MVC standard
        end
      end
    RUBY
  end

  it 'registers an offense when sending email from a controller with deliver_later' do
    expect_offense(<<~RUBY)
      class UsersController < ApplicationController
        def send_email
          UserMailer.welcome_email.deliver_later
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Captive/Rails/NoEmailFromController: Do not send emails from controllers. Because it doesn\'t follow the MVC standard
        end
      end
    RUBY
  end
end
