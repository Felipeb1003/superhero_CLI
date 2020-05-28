class CLI 
    def start
      puts "\n"
      puts "\nWelcome to the Superhero fact checker!"
      self.first_step
    end
  
   def first_step
          self.ask_user_for_superhero_name
          self.select_a_superhero
          self.display_categories
          self.select_a_category
          sleep(1)
          self.users_choice
   end

    def display_search_name_result
        SuperHero.all.each.with_index(1) do |hero , index|
        puts "#{index}. #{hero.name}."
        end
    end

    def display_categories
      @categories = ["Appearance", "Biography", "Powerstats", "Work"]
      puts "Categories:"
      @categories.each.with_index(1) do |category, index|
        
        puts "#{index}. #{category}."
      end
    end

    def ask_user_for_superhero_name
        puts "\n"
        puts "Please enter the name of the Superhero you are looking for:"
        input_superhero_name= gets.strip.downcase
    
        #Validate the input
        until API.fetch_superhero(input_superhero_name) 
            puts "Superhero not found. (ง'̀-'́)ง Please try again."
            
            input_superhero_name= gets.strip.downcase
        end
               self.display_search_name_result
    end
    
    

    def select_a_superhero
      puts "\nPlease Select the character you would like to look at:"
       index = gets.strip.to_i - 1

       #Validate input
       max_limit = SuperHero.all.length - 1
       until index.between?(0, max_limit) 
        puts "⇪ Invalid number. Please try again."
        index = gets.strip.to_i - 1
       end
       @superhero_instance= SuperHero.all[index]
       puts "\n *#{@superhero_instance.name}*"
       
    end
       
    def select_a_category
      puts "Please select the category that you would like to see or type:"
      index = gets.strip.to_i - 1
    
      #validate
      max_limit= @categories.length - 1

      until index.between?(0, max_limit)
        puts "⇪ Invalid number. Please try again."
        index = gets.strip.to_i - 1
      end  

      case index

      when 0
        self.user_chose_appearance
      when 1   
        self.user_chose_biography
      when 2
        self.user_chose_powerstats
      when 3
        self.user_chose_work
      end  
   end
   
   def user_chose_appearance
    puts "\n*#{@superhero_instance.name}*"
    puts "1. Appearance."
    puts "\n"
      
      @superhero_instance.appearance.each do |key, value|
          if key == "height" || key == "weight"
            puts "-#{key.capitalize} = #{value[0]} || #{value[1]} "
          elsif
            puts "-#{key.capitalize} = #{value}"
          end
      end
   end

   def user_chose_biography
    puts "\n*#{@superhero_instance.name}*"
    puts "2. Biography."
    puts "\n"
    
      @superhero_instance.biography.each do |key, value|
        if key == "aliases"
            if value.length > 1  
                puts "-#{key.capitalize} =" 
                value.each{ |name| puts"~~>#{name}."}
            elsif value.length == 1
                puts "-#{key.capitalize} = #{value.join}"
            end
        elsif
            puts "-#{key.capitalize} = #{value}"
        end
        
      end
   end

   def user_chose_powerstats
      puts "*#{@superhero_instance.name}*"
      puts "3. Powerstats."
      @superhero_instance.powerstats.each do |key, value|
        puts "-#{key.capitalize} = #{value}"
      end
   end

   def user_chose_work
      puts "*#{@superhero_instance.name}*"
      puts "4. Work."
      @superhero_instance.work.each do |key, value|
        puts "-#{key.capitalize} = #{value}"
      end
   end

   def users_choice
    
    puts "\nto select another category: type '1'"
    puts "to select a new superhero from your search: type '2'"
    puts "to start a new search: type '3'"
    puts"to exit: type '4'"
    index = gets.strip.to_i
    until index.between?(1, 4)
      puts "⇪ Invalid number. Please try again."
       index = gets.strip.to_i
    end  

    case index

      when 1
        puts "\n"
        self.display_categories
        self.select_a_category
        sleep(2)
        self.users_choice
      when 2
        puts "\n"
        self.display_search_name_result
        self.select_a_superhero
        self.display_categories
        self.select_a_category
        sleep(2)
        self.users_choice
      when 3 
        puts "\n"
        SuperHero.reset_all
        self.first_step
      when 4
        sleep(1)
        puts ' "Dreams save us.'
        puts "  Dreams lift us up and transform us."
        puts "  And on my soul I swear..."
        puts "  Until my dream of a world where dignity, honor,"
        puts "  and justice becomes the reality we all share..."
        puts "  I'll never stop fighting. EVER." + '"'
        puts "  SUPERMAN"

        sleep(1)
        exit  
    end

   end

end  
 
