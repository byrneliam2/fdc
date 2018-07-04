# Liam Byrne (byrneliam2)
# fdc

# Collection of all printer classes specifically aimed at each type of process

class ClosurePrinter 

  attr_writer :schema

  def print(args)
    args.each do |k, v|
    m = v == Set.new(@schema) ? "[Key]" : "" # key marker
    puts "#{k.to_s
      .gsub("\"", "")
      .gsub("[", "")
      .gsub("]", "")} -> #{v.to_a.to_s
      .gsub("\"", "")
      .gsub("[", "{")
      .gsub("]", "}")} #{m}"
    end
  end

end

class MinimalCoverPrinter 

  def print(args)
    args.each do |f|
    puts "#{f.lhs.to_a.to_s
      .gsub("[", "{")
      .gsub("]", "}")
      .gsub("\"", "")} -> #{f.rhs.to_a.to_s
      .gsub("[", "{")
      .gsub("]", "}")
      .gsub("\"", "")}"
    end
  end

end

class NormalFormPrinter 

  def print(args)
    puts "Highest normal form is #{args}"
  end

end