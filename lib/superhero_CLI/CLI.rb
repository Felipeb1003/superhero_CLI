class CLI 

    def start
      puts "\n"
      puts "\n " + Rainbow("Welcome to the Superhero Fact Checker!").red.underline
      puts Rainbow("\n Here you can find everything you want to know about your favorite SuperHeroes!").darkgoldenrod
      self.first_step
    end
  
   def first_step
          self.ask_user_for_superhero_name
          self.select_a_superhero
          self.display_categories
          self.select_a_category
          sleep(2)
          self.users_choice
   end

    def display_search_name_result
        puts "\n"
        SuperHero.all.each.with_index(1) do |hero , index|
        puts Rainbow(" #{index}. ").darkgoldenrod + "#{hero.name}."
        end
    end

    def display_categories
      @categories = ["Appearance", "Biography", "Powerstats", "Work"]
      puts Rainbow("Categories:").red
      @categories.each.with_index(1) do |category, index|
        
        puts Rainbow(" #{index}. ").darkgoldenrod + "#{category}." 
      end
    end

    def ask_user_for_superhero_name
        puts Rainbow("\nPlease enter the name of the Superhero you are looking for:").cyan
        input_superhero_name= gets.strip.downcase
    
        until API.fetch_superhero(input_superhero_name) 
            puts Rainbow("\nSuperhero not found.").cyan + Rainbow(" (ง'̀-'́)ง ").darkgoldenrod + Rainbow("Please try again.").cyan
            
            input_superhero_name= gets.strip.downcase
        end
            self.display_search_name_result

    end
    
    def select_a_superhero
      puts Rainbow("\nPlease Select the number of the character you would like to look at:").cyan
       index = gets.strip.to_i - 1
       max_limit = SuperHero.all.length - 1

       until index.between?(0, max_limit) 
        puts Rainbow("\n⇪ ").darkgoldenrod +  Rainbow("Invalid number. Please try again.").cyan
        index = gets.strip.to_i - 1
       end

        @superhero_instance= SuperHero.all[index]
        puts Rainbow("*#{@superhero_instance.name}*").darkgoldenrod
       
    end
       
    def select_a_category
      puts Rainbow("\nPlease select the number of the category that you would like to see or type '").cyan + Rainbow("5").darkgoldenrod + Rainbow("' to exit:").cyan
      index = gets.strip.to_i - 1
      

      until index.between?(0, 4)
        puts Rainbow("\n⇪ ").darkgoldenrod +  Rainbow("Invalid number. Please try again.").cyan
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
      when 4
        self.exit_program  
      end  
      

   end
   
   def user_chose_appearance
    puts Rainbow("\n *#{@superhero_instance.name}*").darkgoldenrod
    puts Rainbow("   Appearance.").red
      
      @superhero_instance.appearance.each do |key, value|
        if key == "height" || key == "weight"
          puts Rainbow("    -").darkgoldenrod + Rainbow("#{key.capitalize}").cyan + Rainbow(" = ").darkgoldenrod + "#{value[0]}" + Rainbow(" || ").darkgoldenrod + "#{value[1]}"
        elsif
          puts Rainbow("    -").darkgoldenrod + Rainbow("#{key.capitalize}").cyan + Rainbow(" = ").darkgoldenrod + "#{value}"
        end
      end

   end

   def user_chose_biography
    puts Rainbow("\n *#{@superhero_instance.name}*").darkgoldenrod
    puts Rainbow("   Biography.").red
    
      @superhero_instance.biography.each do |key, value|
        if key == "aliases"
          if value.length > 1  
              puts Rainbow("    -").darkgoldenrod + Rainbow("#{key.capitalize}").cyan + Rainbow(" = ").darkgoldenrod
              value.each{ |name| puts Rainbow("      ~>").darkgoldenrod + "#{name}."}
          elsif value.length == 1
              puts Rainbow("    -").darkgoldenrod + Rainbow("#{key.capitalize}").cyan + Rainbow(" = ").darkgoldenrod + "#{value.join}"
          end

        elsif
          puts Rainbow("    -").darkgoldenrod + Rainbow("#{key.capitalize}").cyan + Rainbow(" = ").darkgoldenrod + "#{value}"
        end 

      end
   end

   def user_chose_powerstats
      puts Rainbow("\n *#{@superhero_instance.name}*").darkgoldenrod
      puts Rainbow("   Powerstats.").red
        @superhero_instance.powerstats.each do |key, value|
          puts Rainbow("    -").darkgoldenrod + Rainbow("#{key.capitalize}").cyan + Rainbow(" = ").darkgoldenrod + "#{value}"
        end

   end

   def user_chose_work
      puts Rainbow("\n *#{@superhero_instance.name}*").darkgoldenrod
      puts Rainbow("   Work.").red
        @superhero_instance.work.each do |key, value|
          puts Rainbow("    -").darkgoldenrod + Rainbow("#{key.capitalize}").cyan + Rainbow(" = ").darkgoldenrod + "#{value}"
        end

   end

   def exit_program
      sleep(1)
      puts "\n"
      puts Rainbow(' "').darkgoldenrod + Rainbow('Dreams save us.').cyan 
      puts Rainbow("  Dreams lift us up and transform us.").cyan
      puts Rainbow("  And on my soul I swear...").cyan 
      puts Rainbow("  Until my dream of a world where dignity, honor,").cyan 
      puts Rainbow("  and justice becomes the reality we all share...").cyan 
      puts Rainbow("  I'll never stop fighting. EVER.").cyan + Rainbow('"').darkgoldenrod
      puts "  " + Rainbow("SUPERMAN").red.underline

      sleep(3)
      exit  
   end

   def users_choice
    puts Rainbow("\n MENU").red
    puts Rainbow("\nTo select another category: type '").cyan + Rainbow("1").darkgoldenrod + Rainbow("'").cyan
    puts Rainbow("To select a new superhero from your search: type '").cyan + Rainbow("2").darkgoldenrod + Rainbow("'").cyan
    puts Rainbow("To start a new search: type '").cyan + Rainbow("3").darkgoldenrod + Rainbow("'").cyan
    puts Rainbow("To exit: type '").cyan + Rainbow("4").darkgoldenrod + Rainbow("'").cyan
    
    index = gets.strip.to_i

      until index.between?(1, 4)
        puts Rainbow("\n⇪ ").darkgoldenrod +  Rainbow("Invalid number. Please try again.").cyan
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
          self.exit_program 
      end
   end

end  
 
