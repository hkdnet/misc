require 'net/http'

class Client
  class Error < StandardError; end

  BASE_URL = 'https://example.com'.freeze

  def initialize(token)
    @token = token
  end

  def execute(body)
    path = '/'
    # GET のときは↓
    # resp = http.get(path, headers)
    resp = http.post(path, body, headers)
    case resp
    when Net::HTTPOK
      resp.body
    else
      # ここどうしようねえ
      raise Error, "error: status #{resp.code}, body #{resp.body}"
    end
  end

  private

  def http
    uri = URI.parse(BASE_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == 'https'
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    http
  end

  def headers
    { 'Authorization': "Bearer #{@token}" }
  end
end
