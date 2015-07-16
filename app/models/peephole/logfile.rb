module Peephole
  class Logfile
    attr_accessor :filename, :path

    LOG_PATH = Rails.root.join('log')

    class << self
      def glob
        Dir.glob(LOG_PATH.join("#{Rails.env}.log*"))
      end

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
    end

    def initialize(path)
      self.path = path
      self.filename = File.basename(path)
    end

    def to_param
      filename
    end

    def loglines(page)
      Logline.where(path, page)
    end
  end
end
