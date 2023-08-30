require 'socket'
require 'uri'
require_relative 'exceptions'

module Twinsies

  DEFAULT_PORT = 1965

  def self.get(uri_string)
    uri = URI(uri_string)
    if uri.scheme != "gemini"
      raise BadRequest.new("Twinsies can only make gemini requests!")
    end

    host = uri.host
    port = uri.port || DEFAULT_PORT

    socket = TCPSocket.new host, port

    document = ""
    while line = socket.gets
      document += line
    end
    socket.close

    document
  end

end
