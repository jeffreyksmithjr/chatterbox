defmodule Chatterbox.Knowledge do

  use Hedwig.Responder

  def start_link do
    Agent.start_link(fn -> MapSet.new end, name: :knowledge)
  end

  defp liked?(key) do
    knowledge = Process.whereis(:knowledge)
    Agent.get(knowledge, &MapSet.member?(&1, key))
  end

  def put(key) do
    knowledge = Process.whereis(:knowledge)
    Agent.update(knowledge, &MapSet.put(&1, key))
  end

  defp speak_likes(sentiment, thing) do
    Enum.join(["I really ",sentiment, " ", thing, "!"])
  end

  defp speak_acknowledgment(thing) do
    Enum.join(["Ok. I will like ", thing, ", then."])
  end

  def answer(thing) do
    cond do
      liked?(thing) -> speak_likes("like", thing)
      true -> speak_likes("don't like", thing)
    end
  end

  hear ~r/Do you really like (\w+)\?/i, msg do
    reply msg, answer(msg.matches[1])
  end

  hear ~r/You should really like (\w+)\./i, msg do
    thing = msg.matches[1]
    put(thing)
    reply msg, speak_acknowledgment(thing)
  end

end
