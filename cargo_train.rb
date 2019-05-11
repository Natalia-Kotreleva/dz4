class CargoTrain < Train 

protected
 
  def add_wagon(wagon)
    if (wagon.class.name == "CargoWagon") && (@speed == 0) 
      self.wagons.push(wagon)
      puts "Добавлено."
    end
  end

  def wagon_decrease(wagon)
    if (wagon.class.name == "CargoWagon") && (@speed == 0)
      self.wagons.delete(wagon)
      puts "Удалено."
    end
  end
end
