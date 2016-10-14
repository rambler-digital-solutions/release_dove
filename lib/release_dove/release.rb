# frozen_string_literal: true
class ReleaseDove::Release
  attr_reader :id, :date, :header, :content

  CHANGELOG = './CHANGELOG.md'
  TAG = /^##\s(?:\[Unreleased\]|\[\d+\.\d+\.\d+\]\s\-\s\d{4}\-\d{2}\-\d{2})$/i
  DATE = /\d{4}\-\d{2}\-\d{2}/

  class << self
    def all
      return @all if @all

      @all = []
      releases.each { |*args| @all << new(*args) }

      @all
    end

    def take
      all.first
    end

    alias last take

    def first
      all.last
    end

    def size
      all.size
    end
    alias count size
    alias length size

    def find(id)
      id = id.to_i
      releases = all
      length = releases.length
      return unless (1..length).cover? id

      i = length - id
      releases.fetch(i)
    end

    private

    def releases
      return to_enum(:releases) unless block_given?

      log_content, log_indices = read_from_file

      log_indices.each_with_index do |position, i|
        next_position = log_indices[i + 1]
        length = next_position ? next_position - position : log_content.length - position
        id = log_indices.size - i
        content = log_content[position, length]

        yield id, content
      end
    end

    def read_from_file
      file = File.open(CHANGELOG, 'rb', encoding: 'utf-8')
      content = file.read
      indices = content.enum_for(:scan, TAG).map { Regexp.last_match.begin(0) }
      file.close

      [content, indices]
    end
  end

  def initialize(id, content)
    @id = id
    @content = content
    @header = @content.slice TAG
    @date = @header.slice(DATE)&.to_date
  end

  def ==(other)
    id == other.id
  end
end
