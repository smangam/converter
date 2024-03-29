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

  #check for only numeric values for ARGV[0] and ARGV[2]
  if $input_value =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/ && $output_value =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
    $input_value=$input_value.to_f
    $output_value=$output_value.to_f
  else
    puts "invalid"
    exit
  end

  #check if the units are valid
  if $input_unit =~ /^k|^c|^f|^r|^l|^t|^cubic-i|^cup|^cubic-f|^g/
     if $input_unit =~ /^k|^c|^f|^r/ 
       unless $output_unit =~ /^k|^c|^f|^r/
         puts "invalid. Input and Output units must be one of the folllowing: "+$temp.join(',')
         exit
       end
       rankine_value = convert_to_rankine($input_unit,$input_value)
       correct_value = convert_from_rankine($output_unit,rankine_value).round(10)
       check_results($output_value,correct_value)
     elsif $input_unit =~ /^l|^t|^cubic-i|^cup|^cubic-f|^g/ 
       unless $output_unit =~ /^l|^t|^cubic-i|^cup|^cubic-f|^g/
         puts "invalid. Input and Output units must be one of the folllowing: "+$vol.join(',')
         exit
       end
       liter_value = convert_to_liter($input_unit,$input_value)
       correct_value = convert_from_liter($output_unit,liter_value).round(10)
       check_results($output_value,correct_value)
     end
  else
    puts "invalid. #{$input_unit} is not a valid unit"
    exit
  end
end

def check_results(output_value, correct_value)
  if output_value.round(10) == correct_value.round(10)
   $result="correct"
  else
   $result="incorrect. correct value is #{correct_value}"
  end
  puts $result
end

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

def convert_to_liter(input_unit,v)
  if input_unit =~ /^l/
    v
  elsif input_unit =~ /^cubic-f/
    (v * 28.316846592)
  elsif input_unit =~ /^t/
    (v * 0.0147867647825 )
  elsif input_unit =~ /^cubic-i/
    (v * 0.016387064 )
  elsif input_unit =~ /^cup/
    (v * 0.23658823650000002 )
  elsif input_unit =~ /^g/
    (v * 3.7854117840000003)
  end
end

def convert_from_liter(output_unit,i)
  if output_unit =~ /^l/
    i
  elsif output_unit =~ /^cubic-f/
    (i * 0.03531466672099418)
  elsif output_unit =~ /^t/
    (i * 67.62804539796906)
  elsif output_unit =~ /^cubic-i/
    (i * 61.02374409473229)
  elsif output_unit =~ /^cup/
    (i * 4.226752837730375)
  elsif output_unit =~ /^g/
    (i * 0.2641720523581484 )
  end
end

# main program
user_input
