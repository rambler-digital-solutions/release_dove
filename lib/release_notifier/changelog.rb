class Changelog
  attr_reader :id, :date, :header, :content

  # CHANGELOG = Rails.root.join 'CHANGELOG.md'
  CHANGELOG = './CHANGELOG.md'
  TAG = /^##\s(?:\[Unreleased\]|\[\d+\.\d+\.\d+\]\s\-\s\d{4}\-\d{2}\-\d{2})$/i
  DATE = /\d{4}\-\d{2}\-\d{2}/

  class << self
    @all = nil

    def all
      return @all unless @all.blank?
      @all = []

      log_string = read_from_file

      fetch_releases_from log_string do |id, content|
        @all << new(id, content)
      end

      @all
    end

    def take
      all.first
    end

    alias last take

    def first
      all.last
    end

    delegate :size, to: :all
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

    def fetch_releases_from(log_string)
      log_indices = log_string.enum_for(:scan, TAG).map { Regexp.last_match.begin(0) }

      log_indices.each_with_index do |position, i|
        next_position = log_indices[i + 1]
        length = next_position ? next_position - position : log_string.length - position
        id = log_indices.size - i
        content = log_string[position, length]

        yield id, content
      end
    end

    def read_from_file
      file = File.open(CHANGELOG, 'rb', encoding: 'utf-8')
      content = file.read
      file.close

      content
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
