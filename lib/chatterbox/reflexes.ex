defmodule Chatterbox.Reflexes do

  use Hedwig.Responder

  import Chatterbox.Speech, only: [speak_and_type: 2]

  @answers ["I like ", "I don't like "]

  defp answer(thing) do
    sentiment = random(@answers)
    Enum.join([sentiment, thing, "!"])
  end

  hear ~r/Do you like (\w+)\?/i, msg do
    reply_text = answer(msg.matches[1])
    speak_and_type(msg, reply_text)
  end

end
