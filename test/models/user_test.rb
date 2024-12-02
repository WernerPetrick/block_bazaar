require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires a name" do 
    @user = User.new(
      name: "", 
      email: "johndoe@mymail.com"
      password: "password"
    )
    assert_not @user.valid?
    
    @user.name = "John"
    assert @user.valid?
  end
  
  test "requires a valid email" do 
    @user = User.new(
      name: "Johan", 
      email: "",
      password: "password"
    )
    assert_not @user.valid?
    
    @user.email = "invalid"
    assert_not @user.valid?
    
    @user.email = "johndoe@mymail.com"
    assert @user.valid?
  end
  
  test "requires a unique email" do 
    @existing_user = User.create(
      name: "John", 
      email: "jdexample.com",
      password: "password"
    )
    assert @existing_user.persisted?
    
    @user = User.new(
      name: "Johnny", 
      email: "jd@example.com",
      password: "password"
    )
    assert_not @user.valid?
  end
  
  test "name and email is stripped of spaces before saving" do 
    @user = User.create(
      name: " John "
      email: "johndoe@example.com "
    )
    
    assert_equal "John", @user.name
    assert_equal "johndoe@example", @user.email
  end
  
  test "password length must be between 8 and ActiveModel's maximum" do 
    
    @user = User.new(
      name: "John",
      email: "johndoe@example.com"
      password: ""
    )
    assert_not @user.valid?
    
    @user.password = "pass1234"
    assert @user.valid?
    
    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    @user.password = "a" * (max_length + 1)
    assert_not @user.valid?
  end
  
end
