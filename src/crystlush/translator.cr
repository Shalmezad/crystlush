module Crystlush
  class Translator
    def translate(genome : Array({instruction: String, silent: Bool, close: Int32}))
      open_paren_stack = [] of String
      program_stack = [] of String
      genome.each do |gene|
        # If we're silent, we don't affect anything
        next if gene[:silent]
        # Check if we're a special instruction:
        if special_instruction(gene)
          handle_special_instruction(gene, program_stack, open_paren_stack)
        else
          # We're a regular instruction:
          # Add us to the stack:
          program_stack << gene[:instruction]
          # See if we need to add any parenthesis:
          metadata = METADATA.find{|m|m[:instruction] == gene[:instruction]}
          if metadata
            # We need to tweak:
            program_stack << "("
            open_paren_stack << ":close"
            open_close_count = metadata[:parens] - 1
            open_close_count.times do
              open_paren_stack << ":close_open"
            end
          end
          # See if we need to take off parenthesis:
          gene[:close].times do
            if open_paren_stack.size > 0
              # Pop one off, add the instructions:
              paren = open_paren_stack.pop
              if paren == ":close"
                program_stack << ")"
              elsif paren == ":close_open"
                program_stack << ")"
                program_stack << "("
              end
            end
          end
        end
      end
      while open_paren_stack.size > 0
        # Pop one off, add the instructions:
        paren = open_paren_stack.pop
        if paren == ":close"
          program_stack << ")"
        elsif paren == ":close_open"
          program_stack << ")"
          program_stack << "("
        end
      end

      return "( " + program_stack.join(" ") + " )"
    end

    def special_instruction(gene)
      return gene[:instruction] == "NOOP.OPENPAREN"
    end

    def handle_special_instruction(gene, program_stack, open_paren_stack)
      if gene[:instruction] == "NOOP.OPENPAREN"
        program_stack.push "("
        open_paren_stack.push ":close"
      end
    end
  end
end
