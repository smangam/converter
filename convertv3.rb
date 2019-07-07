#!/usr/bin/ruby
##########################################
# program to convert temperatue or volumes
# author: Sunny Mangam
# date: July 06 2019
##########################################

# declare arrays for temperature and volume units
$temp="kelvin,celsius,fahrenheit,rankine".split(',')
$vol="liters,tablespoons,cubic-inches,cups,cubic-Feet,gallons".split(',')

def user_input
  if ARGV.length < 4
    puts "Incorrect number of arguments"
    puts "Usage: <input_value> <input_unit> <output_value> <output_unit>"
    puts "Temperature units: "+$temp.join(',')
    puts "Volume units: "+$vol.join(',')
    exit
  else
    $input_value = ARGV[0]
    $input_unit = ARGV[1].downcase
    $output_value = ARGV[2]
    $output_unit = ARGV[3].downcase
  end

  #check for only numeric values for ARGV[0] and ARGV[3]
  if $input_value =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/ && $output_value =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
    $input_value=$input_value.to_f
    $output_value=$output_value.to_f
  else
    puts "Input/Output values should be numbers."
    exit
  end

  #check if the units are valid
  if $input_unit =~ /^k|^c|^f|^r|^l|^t|^cubic-i|^cup|^cubic-f|^g/
     if $input_unit =~ /^k|^c|^f|^r/ 
       unless $output_unit =~ /^k|^c|^f|^r/
         puts "Input and Output units must be one of the folllowing: "+$temp.join(',')
         exit
       end
       rankine_value = convert_to_rankine($input_unit,$input_value)
       correct_value = convert_from_rankine($output_unit,rankine_value)
       check_results($output_value,correct_value)
     elsif $input_unit =~ /^l|^t|^cubic-i|^cup|^cubic-f|^g/ 
       unless $output_unit =~ /^l|^t|^cubic-i|^cup|^cubic-f|^g/
         puts "Input and Output units must be one of the folllowing: "+$vol.join(',')
         exit
       end
     end
  else
    puts "#{$input_unit} is not a valid unit"
    puts "Temperature units must be one for the following: "+$temp.join(',')
    puts "Volume units must be one of the following: "+$vol.join(',')
    exit
  end
end

def check_results(output_value, correct_value)
  if output_value == correct_value
   $result="correct"
  else
   $result="incorrect"
  end
  puts $result
end

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
def convert_to_rankine(input_unit,t)
  if input_unit =~ /^k/
    t * (1.8)
  elsif input_unit =~ /^c/
    (t * 1.8) + 32 + 459.67
  elsif input_unit =~ /^f/
    t + 459.67
  elsif input_unit =~ /^r/
    t
  end
end


def convert_from_rankine(output_unit,t)
  if output_unit =~/^k/
    t * (5.0 / 9.0)
  elsif output_unit =~ /^c/
    (t - 491.67) * (5.0 /9.0)
  elsif output_unit =~ /^f/
    t - 459.67
  elsif output_unit =~ /^r/
    t
  end
end

#liters,tablespoons,cubic-inches,cups,cubic-feet,gallons
def convert_to_liter(source_unit,i)
  if source_unit == 'L'
    i
  elsif source_unit == 'cubic-feet'
    (i * 28.317)
  elsif source_unit == 'tablespoon'
    (i / 67.628)
  elsif source_unit == 'cubic-inches'
    (i / 61.024)
  elsif source_unit == 'cups'
    (i / 4.167)
  elsif source_unit == 'gallons'
    (i * 3.785)
  end
end

def convert_from_liter(target_unit,i)
  if target_unit == 'L'
    i
  elsif target_unit == 'cubic-feet'
    (i / 28.317)
  elsif target_unit == 'tablespoon'
    (i * 67.628)
  elsif target_unit == 'cubic-inches'
    (i * 61.024)
  elsif target_unit == 'cups'
    (i * 4.167)
  elsif target_unit == 'gallons'
    (i / 3.785)
  end
end

def menu
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
  elsif choice=="2"
    volume_converter
  elsif choice=="3"
    puts "exiting..."
    exit
  end
end
end

# main program
user_input
