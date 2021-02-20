class OrdersView
  def ask_index
    puts "Enter index:"
    gets.chomp.to_i - 1
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} | Meal: #{order.meal.name} | Customer: #{order.customer.name} | Rider: #{order.employee.username}"
    end
  end
end
