#!/usr/bin/ruby
##########################################
# program to convert temperatue or volumes
# author: Sunny Mangam
# date: July 06 2019
##########################################

# declare arrays
temp="Kelvin,Celsius,Fahrenheit,Rankine".split(',')
vol="liters,tablespoons,cubic-inches,cups,cubic-feet,gallons".split(',')


def temperature_converter
  loop do
    print  "Enter Source Temperature Unit (K,C,F,R):"
    $source_unit=gets.chomp.upcase
    if  $source_unit =~/[KCFR]/
      break
    else
      puts "Temperature unit should be K,C,F, or R. Please try again..."
    end
  end

  loop do
    print "Enter Source Temperature Value:"
    $i=gets.chomp
    if $i =~ /^[.0-9]+$/ && $i.to_i > 0
      $i=$i.to_f
      break
    else
      puts "Temperature value should be a number. Please try again..."
    end
  end

  loop do
    print  "Enter target temperature unit (K,C,F,R):"
    $target_unit=gets.chomp.upcase
    if  $target_unit =~/[KCFR]/
      break
    else
      puts "Temperature unit should be K,C,F, or R. Please try again..."
    end
  end
end

# first convert user input to rankine
def convert_to_rankine(source_unit,i)
  if source_unit=='K'
   rankine_value = i * (1.8)
   puts rankine_value
  elsif source_unit=='C'
   rankine_value = (i * 1.8) + 32 + 459.67
  elsif source_unit=='F'
   rankine_value = i + 459.67
  elsif source_unit=='R'
   rankine_value = i
  end
  rankine_value
end


def convert_from_rankine(target_unit,i)
  if target_unit=='K'
   i * (5.0 / 9.0)
  elsif target_unit=='C'
   (i - 491.67) * (5.0 /9.0)
  elsif target_unit=='F'
   i - 459.67
  elsif target_unit=='R'
   i
  end
end

#liters,tablespoons,cubic-inches,cups,cubic-feet,gallons
def convert_to_liter(source_unit,i)
  if source_unit == 'L'
    i
  elsif source_unit == 'cubic'
    (i / 28.317)
  elsif source_unit == 'tablespoon'
    (i * 67.628)
  elsif source_unit == 'cubic-inches'
    (i * 61.024)
  elsif source_unit == 'cups'
    (i * 4.167)
  elsif source_unit == 'gallons'
    (i / 3.785)
  end
end

def convert_from_liter(target_unit,i)

end

## main program
loop do
  print "Make a Selection:
  (1) Convert Temperatures
  (2) Convert Volumes
  (3) Exit
  Enter Choice:"
  choice=gets.chomp

  if choice=="1"
    temperature_converter
    rankine_value = convert_to_rankine($source_unit,$i)
    puts "rankine value is #{rankine_value}"
    puts convert_from_rankine($target_unit,rankine_value)
  elsif choice=="3"
    puts "exiting..."
    exit
  end
end
