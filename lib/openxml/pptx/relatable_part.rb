module OpenXml
  module RelatablePart

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def relationship_type(*args)
        @relationship_type = args.first if args.any?
        @relationship_type
      end

      def default_path(*args)
        @default_path = Pathname.new(args.first) if args.any?
        @default_path
      end

      def content_type(*args)
        @content_type = args.first if args.any?
        @content_type
      end

    end

    attr_accessor :parent

    def initialize(options={})
      @parent = options[:parent]
      super()
    end

    def relationships
      @relationships ||= OpenXml::Parts::Rels.new
    end

    def relationships_by_path
      @relationships_by_path ||= {}
    end

    def relationship_type
      self.class.relationship_type
    end

    def file_name
      self.class.default_path.basename
    end

    def content_type
      self.class.content_type
    end

    def path
      @path || Pathname.new("#{self.class.default_path.dirname}/#{file_name}")
    end

    def path=(value)
      @path = Pathname.new(value)
    end

    def relationships_path
      directory = self.class.default_path.dirname
      "#{directory}/_rels/#{file_name}.rels"
    end

    def add_child_part(part, with_index: nil)
      part.path = indexed_path(part.path, with_index) unless with_index.nil?
      part.parent = self if part.respond_to?(:parent=)
      add_relationship part.relationship_type, part.path
      return unless instance_variable_defined?("@parent")
      add_part part.path, part
      if part.respond_to?(:relationships_path) && !part.relationships_path.nil?
        rel_path = with_index.nil? ? part.relationships_path : indexed_path(part.relationships_path, with_index)
        add_part rel_path, part.relationships
      end
      add_override part.path, part.content_type if part.respond_to?(:content_type)
    end

    def add_part(part_path, part)
      parent.add_part part_path.to_s, part
    end

    def add_override(part_path, content_type)
      parent.add_override part_path, content_type
    end

    def add_relationship(type, part_path)
      relationship = relationships.add_relationship type, Pathname.new(part_path).relative_path_from(path.dirname)
      relationships_by_path[part_path] = relationship
    end

    def indexed_path(part_path, index)
      extension = part_path.to_s.match(/\w(\..+)$/)[1]
      path_without_extension = part_path.to_s[0...-extension.length]
      Pathname.new("#{path_without_extension}#{index}#{extension}")
    end

  end
end
