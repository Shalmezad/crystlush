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
