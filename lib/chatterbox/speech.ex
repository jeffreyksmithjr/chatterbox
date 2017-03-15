defmodule Chatterbox.Speech do

  use Hedwig.Responder

  def speak_and_type(msg, reply_text) do
    System.cmd "say", [reply_text]
    reply msg, reply_text
  end

end
