require "./spec_helper"

describe Crystlush do
  it "should handle the main example" do
    genome = [] of Crystlush::Gene
    genome.push({instruction: "EXEC.DO*TIMES", close: 0, silent: false})
    genome.push({instruction: "8", close: 0, silent: false})
    genome.push({instruction: "11", close: 3, silent: false})
    genome.push({instruction: "INTEGER.ADD", close: 0, silent: true})
    genome.push({instruction: "EXEC.IF", close: 1, silent: false})
    genome.push({instruction: "17", close: 0, silent: false})
    genome.push({instruction: "NOOP.OPENPAREN", close: 0, silent: false})
    genome.push({instruction: "false", close: 0, silent: false})
    genome.push({instruction: "CODE.QUOTE", close: 0, silent: false})
    genome.push({instruction: "FLOAT.*", close: 2, silent: false})
    genome.push({instruction: "EXEC.ROT", close: 0, silent: false})
    genome.push({instruction: "34.44", close: 0, silent: false})
    expected_program = "( EXEC.DO*TIMES ( 8 11 ) EXEC.IF ( ) ( 17 ( false CODE.QUOTE ( FLOAT.* ) ) EXEC.ROT ( 34.44 ) ( ) ( ) ) )"
    translator = Crystlush::Translator.new
    program = translator.translate(genome)
    program.should eq(expected_program)
  end

  it "should generate a genome" do
    generator = Crystlush::Generator.new
    genome = generator.generate
  end
end
