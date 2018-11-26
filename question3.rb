# noinspection ALL
class Catalogue
  def initialize(filePath)
    @filePath = filePath
    @numberOfCars = 0
    @carsText = []
    @cars = []
    convertListingsToCatalogue
  end

  attr_accessor :cars
  attr_accessor :numberOfCars
  attr_accessor :filePath

  def convertListingsToCatalogue

    text = File.open(@filePath).read
    text.gsub!(/\r\n?/, "\n")
    text.each_line do |line|
      unless line.to_s.length < 2
        @carsText[@numberOfCars] = line.tr('{', '(').tr('}', ')')
        @numberOfCars = @numberOfCars + 1
      end
    end

    km = ""
    type = ""
    transmission = ""
    stockNumber = ""
    driveTrain = ""
    status = ""
    fuelEconomy = ""
    carMaker = ''
    model = ""
    year = ''
    trim = ""
    setOfFeatures = ''
    carIndex = 0

    @carsText.each do |carText|
      carParts = carText.to_s.split(/ *, *(?=[^\)]*?(?:\(|$))/)
      carParts.each do |part|
        if (part.to_s.end_with?('100km'))
          fuelEconomy = part
        elsif (part.to_s.include?('Sedan') || part.to_s.include?('coupe') || part.to_s.include?('hatchback') || part.to_s.include?('station') || part.to_s.include?('SUV'))
          type = part
        elsif (part.to_s.include?('auto') || part.to_s.include?('Manual') || part.to_s.include?('steptronic'))
          transmission = part
        elsif (part.to_s.include?('FWD') || part.to_s.include?('RWD') || part.to_s.include?('AWD'))
          driveTrain = part
        elsif (part.to_s.include?('Used') || part.to_s.include?('new'))
          status = part
        elsif (part.to_s.include?('Honda') || part.to_s.include?('Toyota') || part.to_s.include?('Mercedes') || part.to_s.include?('BMW') || part.to_s.include?('Lexus'))
          carMaker = part
        elsif part.to_s.length == 4
          if (part.to_s.scan(/\D/).empty?)
            year = part
          end
        elsif part.to_s.include?(",")
          setOfFeatures = part

        elsif part.to_s.end_with?("km")
          km = part
        elsif part.to_s.length > 2
          if (part.to_s =~ /\d/ and part.to_s.count("a-zA-Z") > 0)
            stockNumber = part
          end
        elsif part.to_s.length == 2
          trim = part
        else
          if(part.to_s.count("a-zA-Z") > 0)
          model = part
            end
        end
      end

      car = {}
      car['km'] = km
      car['type'] = type
      car['transmission'] = transmission
      car['stockNumber'] = stockNumber
      car['driveTrain'] = driveTrain
      car['status'] = status
      car['fuelEconomy'] = fuelEconomy
      car['carMaker'] = carMaker
      car['model'] = model
      car['year'] = year
      car['trim'] = trim
      car['setOfFeatures'] = setOfFeatures


      @cars[carIndex] = car
      carIndex = carIndex + 1
    end

    def searchInventory (key, value)
      @cars.each do |car|
        if (car[key] == value)
          puts car
        end

      end
    end

    def add2Inventory (listing)
      File.write(@filePath, ("/n"+listing), mode:"a")
    end

    def saveCatalogueToFile(outputFileName)
      @cars = @cars.sort_by {|k| k['carMaker']}
      outputText =' '
      @cars.each_with_index do |car, index|
        if(index<@numberOfCars)
        outputText = outputText <<  @cars[index].values.to_s.tr('"', '').tr('[','').tr(']','').tr('(','{').tr(')','}')
          outputText = outputText + "\n"
          end
      end
      File.open(outputFileName, "w+") do |f|
        f.puts outputText
      end
    end

    def clearTextFile(outputFileName)
      File.truncate(outputFileName, 0)
    end

  end
end

catalogue1 = Catalogue.new("CarCatalogue.txt")
catalogue1.saveCatalogueToFile("OrderedCars2.txt")
catalogue1.add2Inventory('km,Sedan,Manual,18131A,FWD,Used,5.5L/100km,Toyota,camry,SE,{AC, Heated Seats, Heated Mirrors, Keyless Entry},2010')



