# Liam Byrne (byrneliam2)
# fdc

class Printer

    def print(args)
        args.each do |arg|
            # assume arg is a Set from closure calc for now
            arg_arr = arg.to_a
            puts "#{arg_arr[0]} -> #{arg_arr.to_s
                .gsub("\"", "")
                .gsub("[", "{")
                .gsub("]", "}")
            }"
        end
    end

end