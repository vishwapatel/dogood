require 'spec_helper'

describe User do
  it "requires a name" do
  	subject.email = "vishwa@seas.upenn.edu"
  	subject.password = "12345678"
  	subject.password_confirmation = "12345678"
  	subject.gender = "M"

  	subject.should_not be_valid

  	subject.name = "Vishwa Patel"
  	subject.should be_valid
  end
end

describe User do
  it "requires a gender" do
  	subject.name = "Vishwa Patel"
  	subject.email = "vishwa@seas.upenn.edu"
  	subject.password = "12345678"
  	subject.password_confirmation = "12345678"

	subject.should_not be_valid

	subject.gender = "M"
	subject.should be_valid
  end
end
