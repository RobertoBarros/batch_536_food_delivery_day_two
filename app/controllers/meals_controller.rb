require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def add
    # 1. perguntar o name do Meal
    name = @view.ask_name
    # 2. perguntar o price do Meal
    price = @view.ask_price
    # 3. Instaciar um objeto meal
    new_meal = Meal.new(name: name, price: price)
    # 4. Adicionar o objeto meal no repository
    @meal_repository.create(new_meal)
  end

  def list
    # 1. Recuperar todos os meal do repository
    meals = @meal_repository.all
    # 2. Exibir para o usuário
    @view.display(meals)
  end
end