# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RuboCop::Cop::Captive::Sidekiq::CronFormat do
  subject(:cop) { described_class.new }

  it "does not register an offense when the cron value is in the correct format" do
    expect_no_offenses(<<~RUBY)
      Sidekiq::Cron::Job.create(
        my_job: {
          name: 'my_job',
          cron: '0 0 * * *'
        }
      )
    RUBY
  end

  it "registers an offense when the cron value does not have 5 values separated by spaces" do
    expect_offense(<<~RUBY)
      Sidekiq::Cron::Job.create(
        my_job: {
          name: 'my_job',
          cron: '0 0 * *'
                ^^^^^^^^^ The `cron` value must be a string in the format `'0 0 * * *'`
        }
      )
    RUBY
  end

  it "registers an offense when the cron value has more than 5 values separated by spaces" do
    expect_offense(<<~RUBY)
      Sidekiq::Cron::Job.create(
        my_job: {
          name: 'my_job',
          cron: '0 0 * * * *'
                ^^^^^^^^^^^^^ The `cron` value must be a string in the format `'0 0 * * *'`
        }
      )
    RUBY
  end
end
