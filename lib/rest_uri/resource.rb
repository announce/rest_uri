require 'rest_uri/uri'

module RestUri
  module Resource
    # Take a URI string or URI object and return its ID
    # @example
    #   resource_id = RestUri::Resource.resource_id('https://twitter.com/sferik/resource/540897316908331009/')
    #   resource_id #=> 540897316908331009
    # @param name [String] Resource name
    # @param object [Integer, String, URI] An ID, URI, or object.
    # @option parser [Integer, String, URI] An ID, URI, or object.
    # @return [Integer, NilClass]
    def self.resource_id(name, object, parser: DEFAULT_PARSER)
      return nil if not name.respond_to? :empty? or name.empty?
      case object
        when ::Integer
          object
        when ::String
          resource_id(name, parser.parse(object), parser: parser)
        when parser
          resource_id(name, Uri.hashbang_path_or_path(object).split('/'))
        when Enumerable
          Uri.find_resource_id(object) {|s|
            /\A(?:#{name.underscore.singularize}|#{name.underscore.pluralize})\z/ === s
          }
        else
          nil
      end
    end

    def resource(name)
      Resource.resource_id(name, @uri, parser: @parser)
    end

    def method_missing(name, *args)
      super unless name.to_s.end_with? @identifier.to_s
      resource(name[0...-@identifier.to_s.size])
    end

  end
end
