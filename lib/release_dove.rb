# frozen_string_literal: true
require 'release_dove/version'
require 'release_dove/release'

module ReleaseDove
  class Application
    def self.call(*)
      ['200', { 'Content-Type' => 'application/json; charset=utf-8' }, [Release.all.to_json]]
    end
  end
end
