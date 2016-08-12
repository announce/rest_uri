require 'uri'
require 'active_support/inflector'
require 'rest_uri/version'
require 'rest_uri/resource'

module RestUri
  DEFAULT_PARSER = URI
  DEFAULT_IDENTIFIER = :_id

  # Retrieve resource ID from REST URI
  class Base
    include Resource
    attr_accessor :uri, :parser, :identifier

    # @param uri [String, URI]
    # @param parser [Object] :parser URI parser such as Addressable::URI
    # @param identifier [Symbol] :identifier Suffix of method name to specify resource
    # @raise ArgumentError if `identifier` is empty
    def initialize(uri, parser: DEFAULT_PARSER, identifier: DEFAULT_IDENTIFIER)
      raise ArgumentError, 'Empty identifier' if not identifier.respond_to? :empty? or identifier.empty?
      @uri = uri
      @parser = parser
      @identifier = identifier
    end
  end

  # Parse REST URI
  # @see RestUri::Base#initialize
  # @example
  #   require 'addressable/uri'
  #   require 'rest_uri'
  #   rest_uri = RestUri.parse(
  #     'https://twitter.com/yukihiro_matz/status/755950562227605504#尾骶骨',
  #     parser: Addressable::URI)
  #   rest_uri.status_id  #=> 755950562227605504
  def self.parse(uri, **options)
    Base.new(uri, options)
  end

end
