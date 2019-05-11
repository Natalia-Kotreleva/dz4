class Route
  attr_accessor :stations, :route_name

  def initialize(first_station, final_station, route_name)
    @stations = [first_station, final_station]
    @route_name = route_name
  end
    
  def station_add(station)
    if @stations.include?(station) == true
      puts "Станция уже существует"
    else
      @stations.insert(-2, station)
      puts "Станция добавлена"
    end
  end

  def station_delete(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
      puts "Станция удалена"
    else
      puts "Выберите станцию, которая не является начальной/конечной."
    end
  end
end

