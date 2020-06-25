class Customer
    attr_accessor :name, :age
  
    @@all = []
  
    def initialize(name, age)
      @name = name
      @age = age
      @@all << self
    end
  
    def self.all
      @@all
    end
  
    #creating the bridge 
    def new_meal(waiter, total, tip=0)
        #Meal is the bridge between customer class & meal class, self is a reference to the current instance of customer
        Meal.new(waiter, self, total, tip)    
    end

    def meals
        Meal.all.select do |meal|
            meal.customer == self
        end
    end

    #since we have a #meals method to obtain an array of meals (def above), we can reuse it to write a #waiters method
    def waiters
        meals.map do |meal|
            meal.waiter
        end
    end
    def new_meal_20_percent(waiter, total)
        tip = total * 0.2
        Meal.new(waiter, self, total, tip)
      end
    
      def self.oldest_customer
        oldest_age = 0
        oldest_customer = nil
        self.all.each do |customer|
          if customer.age > oldest_age
            oldest_age = customer.age
            oldest_customer = customer
          end
        end
        oldest_customer
      end

  end