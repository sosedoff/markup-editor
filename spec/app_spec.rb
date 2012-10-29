require 'spec_helper'

describe 'Application' do
  context 'GET /' do
    it 'returns editor page' do
      get '/'
      last_response.should be_ok
      last_response.body.should include "editor_output"
      last_response.body.should include "editor_output"
    end
  end

  context 'POST /render' do
    let(:render_url) { '/render' }

    it 'returns an empty page' do
      post render_url
      last_response.should be_ok
    end

    it 'requires a valid markup' do
      post render_url, :content => "Hello World", :markup => "invalidmarkup"
      last_response.should_not be_ok
      last_response.body.should match(/invalid markup/i)
    end

    it 'returns content for markups' do
      %w(markdown textile rdoc).each do |m|
        post render_url, :content => "Hello world", :markup => m
        last_response.should be_ok
        last_response.body.should match(/Hello world/)
      end
    end
  end
end