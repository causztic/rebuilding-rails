require "multi_json"

module Rulers
  module Model
    class FileModel
      attr_reader :hash
      
      def initialize(filename)
        @filename = filename

        # If filename is "dir/37.json", @id is 37
        basename = File.split(filename)[-1]
        @id = File.basename(basename, ".json").to_i

        obj = File.read(filename)
        @hash = MultiJson.load(obj)
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def to_json
        MultiJson.dump(@hash)
      end

      def save(params)
        # for now, only update the first json
        self['submitter'] = params['submitter']

        File.open("db/quotes/1.json", "w") do |f|
          f.write <<~TEMPLATE
            #{self.to_json}
          TEMPLATE
        end
      end
      
      def self.all
        files = Dir["db/quotes/*.json"]
        files.map { |f| FileModel.new(f) }
      end

      def self.find(id)
        FileModel.new("db/quotes/#{id}.json")
      rescue
        nil
      end

      def self.create(attrs)
        files = Dir["db/quotes/*.json"]
        names = files.map { |f| File.split(f)[-1] }
        id = names.map { |b| b.to_i }.max + 1

        hash = {
          "submitter" => attrs["submitter"] || "",
          "quote" => attrs["quote"] || "",
          "attribution" => attrs["attribution"] || "",
        }

        File.open("db/quotes/#{id}.json", "w") do |f|
          f.write <<~TEMPLATE
            {
              "submitter": "#{hash['submitter']}",
              "quote": "#{hash['quote']}",
              "attribution": "#{hash['attribution']}"
            }
          TEMPLATE
        end

        FileModel.new("db/quotes/#{id}.json")
      end

      def self.method_missing(method_name, *args, &block)
        if method_name.to_s =~ /^find_all_by_(.*)/
          FileModel.all.select { |file| file[$1] == args[0] }
        else
          super
        end
      end

      def self.respond_to_missing?(method_name, include_private = false)
        method_name.to_s.start_with?('find_all_by_') || super
      end
    end
  end
end