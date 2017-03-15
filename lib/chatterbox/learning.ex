defmodule Chatterbox.Learning do

  use Hedwig.Responder

  import Chatterbox.Speech, only: [speak_and_type: 2]

  def start_link do
    Agent.start_link(fn -> Map.new end, name: :learning)
  end

  defp put(thing, sentiment) do
    knowledge = Process.whereis(:learning)
    Agent.update(knowledge, &Map.put(&1, thing, sentiment))
  end

  hear ~r/I like (\w+)\./i, msg do
    thing = msg.matches[1]
    put(thing, :like)
    speak_and_type(msg, "Got it.")
  end

  hear ~r/I don't like (\w+)\./i, msg do
    thing = msg.matches[1]
    put(thing, :dontlike)
    speak_and_type(msg, "Ah, sure.")
  end

end
