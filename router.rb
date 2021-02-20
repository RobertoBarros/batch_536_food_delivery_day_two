class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
  end

  def run

    @employee = @sessions_controller.sign_in

    puts '-' * 40
    puts "Logged as #{@employee.username}"
    puts '-' * 40

    loop do
      if @employee.manager?
        print_actions_manager
        action = gets.chomp.to_i
        dispatch_manager(action)
      else
        print_actions_rider
        action = gets.chomp.to_i
        dispatch_rider(action)
      end
    end
  end

  private

  def print_actions_manager
    puts '-' * 40
    puts '1. Create Meal'
    puts '2. List Meals'
    puts '-' * 40
    puts '3. Create Customer'
    puts '4. List Customers'
    puts '-' * 40
    puts '5. Create Order'
    puts '6. List undelivered order'
    puts 'Enter your action:'
  end

  def dispatch_manager(action)
    case action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    end
  end

  def print_actions_rider
    puts '-' * 40
    puts "1. Mark one of my orders as delivered"
    puts "2. List my orders as delivered"
    puts 'Enter your action:'
  end

  def dispatch_rider(action)
    case action
    when 1 then @orders_controller.mark_as_delivered(@employee)
    when 2 then @orders_controller.list_my_orders(@employee)
    end
  end



end