load 'train.rb'
load 'passenger_train.rb'
load 'cargo_train.rb'
load 'passenger_wagon.rb'
load 'cargo_wagon.rb'
load 'station.rb'
load 'route.rb'

choice = "0"
created_trains = []
created_stations = []
created_routes = []

def print_function(array, name)
  array.each { |element|
    print "#{element.send( :"#{name}")}: #{array.index(element) + 1}\n"
  }
end

while (choice != "11")
puts "
  - Создать станцию 1
  - Создать поезд 2
  - Создать маршрут 3
  - Добавить станцию к маршруту 4
  - Удалить станцию из маршрута 5
  - Назначить маршрут поезду 6
  - Добавить вагон 7
  - Отцепить вагон 8
  - Переместить поезд по маршруту 9
  - Вывести список станций и список поездов на станции 10
  - Выход 11"
choice = gets.chomp

case choice  
	when "1"
	  puts "Введите название станции"
	  name_station = gets.chomp
	  name_station = Station.new("#{name_station}")
	  created_stations.push(name_station)
	  puts "Создано."
	  
	when "2"
		puts "Выберите тип поезда: пассажирский (1), грузовой (2)"
		train_type = gets.chomp 
		case train_type
			when "1"
			  puts "Введите имя поезда"
			  passenger_train = gets.chomp
			  passenger_train = PassengerTrain.new("#{passenger_train}")
			  created_trains.push(passenger_train)
			  puts "Создано."
			when "2"
			  puts "Введите имя поезда"
			  cargo_train = gets.chomp
			  cargo_train = CargoTrain.new("#{cargo_train}")
			  created_trains.push(cargo_train)
			  puts "Создано."
		end
		
	when "3"
		if created_stations.size < 2 
			puts "Не создано достаточно станций"
		else
			puts "Введите название маршрута" 
			name_route = gets.chomp
			puts "Выберите номер начальной станции из созданных"
			print_function(created_stations, 'name_station')
			first_station = gets.to_i
			puts "Выберите номер конечной станции, кроме #{first_station}"
			print_function(created_stations, 'name_station')  
			final_station = gets.to_i
		end
		name_route = Route.new(created_stations[first_station - 1], created_stations[final_station-1], "#{name_route}")
		created_routes.push(name_route) 
		puts "Маршрут #{name_route.route_name} создан."
		
	when "4"
	  puts "Выберите номер маршрута для добавления станции"
	  print_function(created_routes, 'route_name')
	  route_number = gets.to_i
	  puts "Какой номер станции добавить?"
	  print_function(created_stations, 'name_station')
	  station_number = gets.to_i
		created_routes[route_number-1].station_add(created_stations[station_number-1])
	  
	when "5"
	  puts "Выберите номер маршрута для удаления станции"
		print_function(created_routes, 'route_name')
	  route_number = gets.to_i
	  puts "Какой номер станции удалить?"
	  print_function(created_stations, 'name_station')
	  station_number = gets.to_i
		created_routes[route_number-1].station_delete(created_stations[station_number-1])
	  
	when "6"
	  puts "Выберите номер поезда для назначения маршрута"	 
	  print_function(created_trains, 'name_train')
	  train_number = gets.to_i
	  puts "Выберите номер маршрута"
	  print_function(created_routes, 'route_name')
	  route_number = gets.to_i
	  created_trains[train_number-1].set_route(created_routes[route_number-1])
	  puts "Назначено."
	  
	when "7"
	  puts "Введите имя вагона"
	  wagon_name = gets.chomp
	  puts "Введите номер поезда, к которому хотите добавить"
	  print_function(created_trains, 'name_train')
	  train_number = gets.to_i
	  if created_trains[train_number-1].class.name == CargoTrain
	    wagon_name = CargoWagon.new
	    created_trains[train_number-1].add_wagon(wagon_name)
	  else 
	    wagon_name = PassengerWagon.new
	    created_trains[train_number-1].add_wagon(wagon_name)
	  end
	  
	when "8"
	  puts "Введите номер поезда, у которого хотите удалить вагон"
	  print_function(created_trains, 'name_train')
	  train_number = gets.to_i
	  puts "Введите номер вагона #{created_trains[train_number-1].wagons}"
	  wagon_number = gets.to_i
	  created_trains[train_number-1].wagon_decrease(created_trains[train_number-1].wagons[wagon_number-1])
	
	when "9"
	  puts "Какой поезд перемещать"
	  print_function(created_trains, 'name_train')	  
	  train_number = gets.to_i
	  if created_trains[train_number-1].route.nil?
	    puts "Поезду не назначен маршрут"
	  else puts "Вперед (1) или назад (2)?"
	    choice = gets.chomp
	    case choice 
	      when "1"
	      	created_trains[train_number-1].station_next
	      when "2"
	      	created_trains[train_number-1].station_prev
	    end
	  end
	      
	when "10"
	  created_stations.each { |st|
	  	puts "Станция: #{st.name_station} поезда на станции: "
	  	st.trains.each { |tr|
	  	  puts "#{tr.name_train}"
	  	}
	  }
	  
end	 
end
 
			  
