require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomersView.new
  end

  def add
    # 1. perguntar o name do customer
    name = @view.ask_name
    # 2. perguntar o address do customer
    address = @view.ask_address
    # 3. Instaciar um objeto customer
    new_customer = Customer.new(name: name, address: address)
    # 4. Adicionar o objeto customer no repository
    @customer_repository.create(new_customer)
  end

  def list
    # 1. Recuperar todos os customer do repository
    customers = @customer_repository.all
    # 2. Exibir para o usuário
    @view.display(customers)
  end
end