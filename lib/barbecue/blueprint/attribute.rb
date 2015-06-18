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

    def to_cli
      if options[:translated]
        I18n.available_locales.map {|locale| "#{name}_#{locale}:#{type}" }
      else
        [ "#{name}:#{type}" ]
      end
    end
  end
end
