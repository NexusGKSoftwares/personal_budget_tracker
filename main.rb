require_relative 'db_setup'
require_relative 'models/user'
require_relative 'models/transaction'

def main_menu
  puts "Welcome to the Personal Budget Tracker!"
  loop do
    puts "\nMain Menu:"
    puts "1. Sign Up"
    puts "2. Log In"
    puts "3. Exit"
    print "Choose an option: "
    choice = gets.chomp.to_i

    case choice
    when 1 then sign_up
    when 2 then log_in
    when 3 then exit
    else puts "Invalid choice. Try again."
    end
  end
end

def sign_up
  print "Enter your email: "
  email = gets.chomp
  print "Enter your password: "
  password = gets.chomp

  user = User.create(email: email, password: password)
  if user.persisted?
    puts "Sign-up successful! You can now log in."
  else
    puts "Sign-up failed: #{user.errors.full_messages.join(', ')}"
  end
end

def log_in
  print "Enter your email: "
  email = gets.chomp
  print "Enter your password: "
  password = gets.chomp

  user = User.find_by(email: email)
  if user&.authenticate(password)
    puts "Welcome back, #{email}!"
    user_dashboard(user)
  else
    puts "Invalid email or password. Try again."
  end
end

def user_dashboard(user)
  loop do
    puts "\nDashboard:"
    puts "1. Add Transaction"
    puts "2. View Transactions"
    puts "3. Log Out"
    print "Choose an option: "
    choice = gets.chomp.to_i

    case choice
    when 1 then add_transaction(user)
    when 2 then view_transactions(user)
    when 3 then break
    else puts "Invalid choice. Try again."
    end
  end
end

def add_transaction(user)
  print "Enter description: "
  description = gets.chomp
  print "Enter amount: "
  amount = gets.chomp.to_f
  print "Enter category (e.g., Food, Rent): "
  category = gets.chomp
  print "Enter date (YYYY-MM-DD): "
  date = gets.chomp

  transaction = user.transactions.create(
    description: description,
    amount: amount,
    category: category,
    date: Date.parse(date)
  )

  if transaction.persisted?
    puts "Transaction added successfully!"
  else
    puts "Failed to add transaction: #{transaction.errors.full_messages.join(', ')}"
  end
end

def view_transactions(user)
  puts "\nYour Transactions:"
  user.transactions.each do |t|
    puts "#{t.date.strftime('%Y-%m-%d')}: #{t.category} - #{t.description} ($#{t.amount})"
  end
end

main_menu
