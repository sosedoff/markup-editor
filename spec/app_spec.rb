require 'spec_helper'

describe 'Application' do
  describe 'GET /' do
    it 'returns editor page' do
      get '/'
      last_response.should be_ok
      last_response.body.should include "editor_output"
      last_response.body.should include "editor_output"
    end
  end

  describe 'POST /render' do
    let(:render_url) { '/render' }

    context 'with no content' do
      it 'renders empty page' do
        post render_url

        expect(last_response).to be_ok
        expect(last_response.body).to be_empty
      end
    end

    context 'with invalid markup' do
      it 'renders error message' do
        post render_url, :content => "Hello World", :markup => "invalidmarkup"
        
        expect(last_response).not_to be_ok
        expect(last_response.body).to match /invalid markup/i
      end
    end

    context 'with valid params' do
      it 'renders generated content' do
        %w(markdown textile rdoc).each do |m|
          post render_url, :content => "Hello world", :markup => m
          
          expect(last_response).to be_ok
          expect(last_response.body).to match /Hello world/
        end
      end
    end
  end
end