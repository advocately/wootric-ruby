require 'net/https'
require 'uri'
require 'cgi'
require 'multi_json'
require 'set'
require 'thread'

require 'wootric/version'
require 'wootric/utils'
require 'wootric/json'

require 'wootric/enumerable_resource_collection'
require 'wootric/resource'
require 'wootric/operations/all'
require 'wootric/operations/retrieve'
require 'wootric/resources/survey_response'
require 'wootric/resources/contact'

require 'wootric/errors'
require 'wootric/http_response'
require 'wootric/http_adapter'
require 'wootric/client'

module Wootric
  @mutex = Mutex.new

  class << self
    attr_accessor :api_key, :api_base_url, :http_adapter
    attr_writer :shared_client

    def shared_client
      @mutex.synchronize do
        @shared_client ||= Client.new(api_key: api_key, api_base_url: api_base_url, http_adapter: http_adapter)
      end
    end
  end
end
