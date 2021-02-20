require_relative '../views/orders_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def add
    # 1. Perguntar qual o meal
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @view.ask_index
    meal = meals[index]

    # 2. Perguntar qual o customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @view.ask_index
    customer = customers[index]

    # 3. Perguntar qual o rider
    riders = @employee_repository.all_riders
    @employees_view.display(riders)
    index = @view.ask_index
    employee = riders[index]

    # 4. Instaciar uma nova Order
    new_order = Order.new(meal: meal, customer: customer, employee: employee)

    # 5. Adicionar order ao repository
    @order_repository.create(new_order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @view.display(orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders
                              .select { |order| order.employee.id == employee.id }

    @view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.undelivered_orders
                              .select { |order| order.employee.id == employee.id }
    @view.display(orders)
    index = @view.ask_index
    order = orders[index]
    order.deliver!

    @order_repository.save_csv



  end
end