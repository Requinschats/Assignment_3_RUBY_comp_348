def processText(file)

    fileName = file.to_s


    characters = File.read(fileName)
    characterCount = characters.size

    text = File.open(fileName, 'r')
    wordCount = 0
    text.each_line(){ |line| wordCount = wordCount + line.split.size }

    sentenceCount = File.read(fileName).count(".")
    sentenceCount = sentenceCount + File.read(fileName).count("?")
    sentenceCount = sentenceCount + File.read(fileName).count("!")

    ari = 4.71*(characterCount/wordCount)+0.5*(wordCount/sentenceCount)-21.43
    roundAri = ari.round


    case roundAri
    when 1
      $category = "Kindergarten"
      $age = "5-6"
    when 2
      $category = "First/Second Grade"
      $age = "6-7"
    when
      $category = "Third Grade"
      $age = "7-9"
    when 4
      $category = "Fourth Grade"
      $age = "9-10"
    when 5
      $category = "Fifth Grade"
      $age = "10-11"
    when 6
      $category = "Sixth Grade"
      $age = "11-12"
    when 7
      $category = "Seventh Grade"
      $age = "12-13"
    when 8
      $category = "Eighth Grade"
      $age = "13-14"
    when 9
      $category = "Ninth Grade"
      $age = "14-15"
    when 10
      $category = "Tenth Grade"
      $age = "15-16"
    when 11
      $category = "Eleventh Grade"
      $age = "16-17"
    when 12
      $category = "Twelfth grade"
      $age = "17-18"
    when 13
      $category = "College student"
      $age = "18-24"
    when 14
      $category = "Professor"
      $age = "24+"
    else
      $category ="ARI out of range"
      $age = " ARI out of range"

    end

    puts ""
    puts "Number of Characters: #{characterCount}"
    puts ""
    puts "Number of words: #{wordCount}"
    puts ""
    puts "Number of sentences: #{sentenceCount}"
    puts ""
    puts "Automated Readability Index: #{ari}"
    puts ""
    puts "Grade level: #{$age} (#{$category})"

  end

processText("ARI348.txt")