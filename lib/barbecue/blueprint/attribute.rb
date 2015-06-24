module Barbecue::Blueprint
  class Attributes < Array
    def to_cli
      map(&:to_cli)
    end
  end

  class  Attribute < Struct.new(:name,:type,:options)
    EMBER_RESERVED = [ 'content' ]

    def initialize(*args)
      super

      if EMBER_RESERVED.include?(name.to_s)
        raise "Ember is using '#{name}' internally. Don't use it as an attribute name!"
      end
    end

    # Example:
    #
    # position:integer
    #
    # or
    #
    # title:string,translated,required
    def to_cli
      cli = [ "#{name}:#{type}" ]
      cli << 'translated' if options[:translated]
      cli << 'required' if options[:required]
      [ cli.join(',') ]
    end
  end
end
