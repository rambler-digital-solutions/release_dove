# frozen_string_literal: true
require 'English'
class ReleaseDove::Release
  attr_reader :id, :date, :version, :header, :content

  CHANGELOG = './CHANGELOG.md'
  TAG = /^.*(?<header>\[(?<version>\d+\.\d+\.\d+)\].*(?<date>\d{4}\-\d{2}\-\d{2}))$/i

  def initialize(id, content)
    @id = id
    @content = content

    return unless TAG =~ content

    @version = $LAST_MATCH_INFO[:version]
    @header = $LAST_MATCH_INFO[:header]
    @date = begin
              Date.parse $LAST_MATCH_INFO[:date].to_s
            rescue ArgumentError
              nil
            end
  end

  def ==(other)
    id == other.id
  end

  class << self
    def all
      @all ||= releases.map { |*args| new(*args) }
    end

    def take
      all.first
    end

    def first
      all.last
    end

    def size
      all.size
    end

    def find(id)
      id = id.to_i
      releases = all
      length = releases.length
      return unless (1..length).cover? id

      i = length - id
      releases.fetch(i)
    end

    alias count size
    alias length size
    alias last take

    private

    def read_from_file
      file = File.open(CHANGELOG, 'rb', encoding: 'utf-8')
      content = file.read
      file.close

      indices = content.enum_for(:scan, TAG).map { Regexp.last_match.begin(0) }

      [content, indices]
    end

    def releases
      return to_enum(:releases) unless block_given?

      log_content, log_indices = read_from_file

      log_indices.each_with_index do |pos, i|
        id = log_indices.size - i

        next_pos = log_indices[i + 1] || log_content.size
        content = log_content[pos, next_pos - pos]

        yield id, content
      end
    end
  end
end
