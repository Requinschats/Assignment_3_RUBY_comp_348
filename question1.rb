class Question1
    def string_lengths (array)
      array.each {|name| puts "#{name}, ch_count= #{name.length}"}
    end
end

  array = ["jim", "pam", "harvey"]
  hello = Question1.new
  hello.string_lengths(array)