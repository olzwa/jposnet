class Posnet::Command::LBDECCSH < Posnet::Command
  escp :checksum => true

  def process_command(amount)
    "1#d%.2f/" % amount
  end
end