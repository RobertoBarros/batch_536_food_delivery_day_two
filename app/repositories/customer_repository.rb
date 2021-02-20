class CustomerRepository

  CSV_OPTIONS = { headers: :first_row, header_converters: :symbol }

  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    load_csv if File.exist?(@csv_file)
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  def all
    @customers
  end

  def find(id)
    @customers.select { |customer| customer.id == id }.first
  end

  def load_csv
    CSV.foreach(@csv_file, CSV_OPTIONS) do |row|
      id = row[:id].to_i
      name = row[:name]
      address = row[:address]

      customer = Customer.new(id: id, name: name, address: address)

      @customers << customer
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb', CSV_OPTIONS) do |csv|
      csv << %i[id name address]

      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
