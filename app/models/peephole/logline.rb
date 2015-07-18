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
      def first_line(page)
        first(page, :line)
      end

      def last_line(page)
        last(page, :line)
      end

      def lines(path, page)
        lines = []
        map = {}
        eof = true
        each(path, page) do |line, i|
          next if i < first_line(page)
          if i >= last_line(page)
            eof = false
            break
          end
          parse(line, i + 1, lines, map)
        end
        [lines, eof]
      end

      def first_byte(page)
        first(page, :byte)
      end

      def last_byte(page)
        last(page, :byte)
      end

      def bytes(path, page)
        eof = true
        raw = ''

        case path.to_s
        when /\.gz\z/
          Zlib::GzipReader.open(path) do |f|
            f.each do |line|
              next if f.pos < first_byte(page)
              if f.pos >= last_byte(page)
                eof = false
                break
              end
              raw << line
            end
          end
        else
          open(path) do |f|
            f.seek(first_byte(page))
            raw = f.read(Peephole.config.bytes_per)
            eof = f.eof?
          end
        end

        [raw, eof]
      end

      private
        def first(page, type)
          (page - 1) * Peephole.config.send("#{type}s_per")
        end

        def last(page, type)
          page * Peephole.config.send("#{type}s_per")
        end

        def parse(line, num, lines, map)
          logline = new(line, num)
          case logline.type
          when TYPE::STARTED
            map[logline.uuid] = logline if logline.uuid.present?
          when TYPE::PARAMS
            line = map[logline.uuid].presence || logline
            line.params = logline.params
            lines << line
          when TYPE::COMPLETED
            map[logline.uuid].try(:status=, logline.status)
          end
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
            params.delete(k)
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
