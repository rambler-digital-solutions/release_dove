class ReleaseNotifier::Release
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

    def releases
      if block_given?
        log_indices = changelog_content.enum_for(:scan, TAG).map { Regexp.last_match.begin(0) }

        log_indices.each_with_index do |position, i|
          next_position = log_indices[i + 1]
          length = next_position ? next_position - position : log_string.length - position
          id = log_indices.size - i
          content = log_string[position, length]

          yield id, content
        end
      else
        self.to_enum(:releases)
      end
    end

    def changelog_content
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
