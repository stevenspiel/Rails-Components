require 'rails_helper'

describe 'Inspect Styles with Rubocop' do
  before do
    @report = `bundle exec rubocop #{Rails.root}`
    puts "Report: #{@report}"
  end

  it 'Does not detect offenses' do
    expect(@report).to_not include('Offenses:')
  end
end
