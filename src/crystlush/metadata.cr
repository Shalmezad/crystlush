module Crystlush
  # Contains metadata on all instructions.
  # Note that this will be constant regardless of what instruction set you're using
  # See Configuration to change what instructions are used
  METADATA = [
    { instruction: "CODE.QUOTE",    parens: 1 },
    { instruction: "EXEC.DO*TIMES", parens: 1 },
    { instruction: "EXEC.IF",       parens: 2 },
    { instruction: "EXEC.ROT",      parens: 3 },
  ]
end
