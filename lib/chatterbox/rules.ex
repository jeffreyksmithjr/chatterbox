defmodule Chatterbox.Rules do

  use Hedwig.Responder

  @answers ["I like ", "I don't like "]

  def answer(thing) do
    sentiment = random(@answers)
    Enum.join([sentiment, thing, "!"])
  end

  hear ~r/Do you like (\w+)\?/i, msg do
    reply msg, answer(msg.matches[1])
  end

end
