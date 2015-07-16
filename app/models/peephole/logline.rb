module Peephole
  class Logline
    attr_accessor :uuid, :type, :num
    attr_accessor :method, :target, :started_at
    attr_accessor :params
    attr_accessor :status

    module TYPE
      STARTED = 1
      PARAMS = 2
      COMPLETED = 3
    end

    class << self
      def first(page)
        (page - 1) * Peephole.config.paginates_per
      end

      def last(page)
        page * Peephole.config.paginates_per
      end

      def where(path, page)
        loglines = []
        logmap = {}
        eof = true
        each(path, page) do |line, i|
          next if i < first(page)
          if i >= last(page)
            eof = false
            break
          end
          logline = new(line, i)
          case logline.type
          when TYPE::STARTED
            logmap[logline.uuid] = logline if logline.uuid.present?
          when TYPE::PARAMS
            if logmap[logline.uuid].present?
              logmap[logline.uuid].params = logline.params
              loglines << logmap[logline.uuid]
            else
              loglines << logline
            end
          when TYPE::COMPLETED
            logmap[logline.uuid].try(:status=, logline.status)
          end
        end
        [loglines, eof]
      end

      def each(path, page, &block)
        iterator = case path.to_s
        when /\.gz\z/
          Zlib::GzipReader.open(path).each
        else
          IO.foreach(path)
        end
        iterator.with_index(&block)
      end
    end

    def initialize(line, num)
      self.num = num

      case line
      when / Started (\w+) "(.+)" .+ at (.+)/
        self.method = $1
        self.target = $2
        self.started_at = Time.parse($3)
        self.type = TYPE::STARTED
      when /   Parameters: ({.+})/
        params = JSON.parse($1.gsub('=>', ':'))
        params.dup.each do |k, v|
          if v.is_a?(Hash)
            v.each do |k2, v2|
              params["#{k}[#{k2}]"] = v2
            end
            params.delete(:k)
          end
        end
        self.params = params
        self.type = TYPE::PARAMS
      when / Completed (\d+)/
        self.status = $1
        self.type = TYPE::COMPLETED
      end
      if line =~ /\[(\w+\-\w+\-\w+\-\w+\-\w+)\] /
        self.uuid = $1
      end
    end
  end
end
