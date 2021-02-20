class SessionsView

  def ask_username
    puts "Enter your username:"
    gets.chomp
  end

  def ask_password
    puts "Enter your password:"
    gets.chomp
  end

  def welcome
    puts "Welcome to Food Delivery App"
  end

  def wrong_credentials
    puts "Wrong Credentials. Try again"
  end

end