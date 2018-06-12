# Liam Byrne (byrneliam2)
# fdc

class Printer

    def print(args)
        # assume arg is a Hash from closure calc for now
        args.each do |k, v|
            puts "#{k.to_s
                .gsub("\"", "")
                .gsub(", ", "")
                .gsub("[", "")
                .gsub("]", "")} -> #{v.to_a.to_s
                .gsub("\"", "")
                .gsub(", ", "")
                .gsub("[", "{")
                .gsub("]", "}")}"
        end
    end

end