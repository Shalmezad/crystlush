module Crystlush
  # Generates *new* crystlush genomes.
  class Generator

    class Configuration
      property instruction_set : Array(String) = [] of String
      property literal_set : Array(String) = [] of String
      property min_random_integer : Int32 = -10
      property max_random_integer : Int32 = 10
      property min_random_float : Float64 = -1.0
      property max_random_float : Float64 = 1.0
      property min_instruction_count : Int32 = 20
      property max_instruction_count : Int32 = 100
    end

    property configuration : Configuration = Configuration.new

    def generate() : Array(Gene)
      rng = Random.new
      genome = [] of Gene
      # Pick a random number of genes to add:
      num_genes = rng.rand(configuration.min_instruction_count..configuration.max_instruction_count)
      num_genes.times do
        genome << pick_gene(rng)
      end
      return genome
    end

    def pick_gene(rng : Random) : Gene
      # Pick one of our operations
      # Or a literal:
      is_literal = rng.next_bool
      operation = ""
      if is_literal
        # Pick a literal:
        operation = pick_literal(rng)
      else
        # Pick an operation:
        operation = pick_operation(rng)
      end

      is_silent = rng.next_bool
      close = rng.rand(3)

      gene : Gene = {instruction: operation, close: close, silent: is_silent}

      return gene
    end

    def pick_operation(rng : Random) : String
      return random_element(configuration.instruction_set, rng)
    end

    def pick_literal(rng : Random) : String
      literal_type = random_element(configuration.literal_set, rng)
      if literal_type == "INTEGER"
        return rng.rand(configuration.min_random_integer..configuration.max_random_integer).to_s
      elsif literal_type == "FLOAT"
        return rng.rand(configuration.min_random_float..configuration.max_random_float).to_s
      elsif literal_type == "BOOLEAN"
        return rng.next_bool.to_s
      else
        puts "Unknown literal type: '#{literal_type}'"
        return ""
      end
    end

    def random_element(array : Array, rng : Random) 
      s = array.size
      index = rng.rand(s)
      return array[index]
    end

  end
end
