require 'spec_helper'

describe EarMark do

  before(:each) do
    @attr = { :url => "http://www.example.com", :name => "Example site", :date_saved => DateTime.now }
  end

  it "should require a url" do
    mark = EarMark.new(@attr.merge(:url => ""))
    mark.should_not be_valid
  end
  
  it "should reject urls that are to short" do
    mark = EarMark.new(@attr.merge(:url => "a" * 9))
    mark.should_not be_valid
  end
  
  it "should accept valid urls" do
    urls = %w[http://www.example.com http://example.com http://staging.example.com http://www.example.org http://www.example.net http://210.50.2.215/sd_new/WebBuilder.cgi?RegID=7449046&amp;First=Ok&amp;Upt=Ok&amp;EditPage=3&amp;S]
    urls.each do |url|
      mark = EarMark.new(@attr.merge(:url => url))
      mark.should be_valid
    end
  end
  
  it "should reject invalid urls" do
    urls = %w[http://www http:example.com http:/staging.example.com http://www..example @example.net]
    urls.each do |url|
      mark = EarMark.new(@attr.merge(:url => url))
      mark.should_not be_valid
    end
  end
  
  it "should require a name" do
    mark = EarMark.new(@attr.merge(:name => ""))
    mark.should_not be_valid
  end
  
  it "should reject names that are to long" do
    mark = EarMark.new(@attr.merge(:name => "a" * 101))
    mark.should_not be_valid
  end

end

# == Schema Information
#
# Table name: ear_marks
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  name       :string(255)
#  date_saved :datetime
#  created_at :datetime
#  updated_at :datetime
#

