module Crystlush
  # Generates *new* crystlush genomes.
  class Generator
    def generate() : Array(Gene)
      rng = Random.new
      genome = [] of Gene
      # Pick a random number of genes to add:
      num_genes = rng.rand(100)
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
      # TODO: Code me
      return "INTEGER.ADD"
    end

    def pick_literal(rng : Random) : String
      # TODO: Code me
      return "5"
    end
  end
end
