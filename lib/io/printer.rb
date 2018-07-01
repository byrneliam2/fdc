# Liam Byrne (byrneliam2)
# fdc

class ClosurePrinter 

    def print(args)
        args.each do |k, v|
            m = "" # key marker
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
    end
    
end

class NormalFormPrinter 

    def print(args)
    end

end