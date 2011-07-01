require 'spec_helper'

describe 'Application' do
  it 'should respond to /' do
    get '/'
    last_response.status.should == 200
  end
  
  it 'should render the content on /render' do
    post '/render'
    
    last_response.status.should == 400
    last_response.body.should match(/Content required/)
    
    post '/render', :content => "Hello world"
    last_response.status.should == 400
    last_response.body.should match(/Markup required/)
    
    post '/render', :content => "Hello world", :markup => 'invalidmarkup'
    last_response.status.should == 400
    last_response.body.should match(/Invalid markup/)
    
    %w(markdown textile rdoc).each do |m|
      post '/render', :content => "Hello world", :markup => m
      last_response.status.should == 200
      last_response.body.should match(/Hello world/)
    end
  end
end