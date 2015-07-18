module Peephole
  class Logfile
    attr_accessor :filename, :path

    LOG_PATH = Rails.root.join('log')

    class << self
      def all
        glob.map do |path|
          Logfile.new(path)
        end
      end

      def find(filename)
        path = glob.find do |path|
          File.basename(path) == filename
        end
        Logfile.new(path)
      end

      private
        def glob
          Dir.glob(LOG_PATH.join("#{Rails.env}.log*"))
        end
    end

    def initialize(path)
      self.path = path
      self.filename = File.basename(path)
    end

    def to_param
      filename
    end

    def lines(page)
      Logline.lines(path, page)
    end

    def bytes(page)
      Logline.bytes(path, page)
    end

    def size
      (File.size(path) / 1024.0).ceil
    end

    def updated_at
      File.mtime(path)
    end
  end
end
