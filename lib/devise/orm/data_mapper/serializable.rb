module Devise
  module Models
    # This module redefines properties_to_serialize in models for more
    # secure defaults. By default, it removes from the serializable model
    # all attributes whose writer or reader is *not* public. You can remove this default
    # by using :force_except and passing a new list of attributes you want
    # to exempt. All attributes given to :exclude will simply add names to
    # exempt to Devise internal list.
    module Serializable
      extend ActiveSupport::Concern

      def properties_to_serialize(options=nil)
        options ||= {}
        if options.key?(:force_except) || options.key?(:force_exclude)
          options[:exclude] = options.delete(:force_except) || options.delete(:force_exclude)
          super(options)
        else
          except = Array(options[:exclude]) + Array(options[:except])
          super(options.merge(:exclude => except + self.class.blacklist_keys))
        end
      end

      # Get back to DataMapper's #to_xml.
      def to_xml(*args)
        super
      end

      module ClassMethods
        # Returns keys that should be removed when serializing the record.
        def blacklist_keys
          @blacklist_keys ||= properties.select { |property| property.reader_visibility != :public || property.writer_visibility != :public }.map(&:name)
        end
      end
    end
  end
end
