require "./spec_helper"

describe Crystlush do
  it "should handle the main example" do
    genome = [
      {:instruction => "EXEC.DO*TIMES", :close => 0},
      {:instruction => "8", :close => 0},
      {:instruction => "11", :close => 3},
      {:instruction => "INTEGER.ADD", :close => 0, :silent => true},
      {:instruction => "EXEC.IF", :close => 1},
      {:instruction => "17", :close => 0},
      {:instruction => "NOOP.OPENPAREN", :close => 0},
      {:instruction => "false", :close => 0},
      {:instruction => "CODE.QUOTE", :close => 0},
      {:instruction => "FLOAT.*", :close => 2},
      {:instruction => "EXEC.ROT", :close => 0},
      {:instruction => "34.44", :close => 0}
    ]
    expected_program = "( EXEC.DO*TIMES ( 8 11 ) EXEC.IF ( ) ( 17 ( false CODE_QUOTE ( FLOAT.* ) ) EXEC.ROT ( 34.4 ) ( ) ( ) ) )"
    program = Crystlush::Translator.translate(genome)
    program.should eq(expected_program)
  end
end
