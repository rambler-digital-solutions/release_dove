# frozen_string_literal: true
require 'release_notifier/version'
require 'release_notifier/release'

module ReleaseNotifier
  class Application
    def self.call(*)
      ['200', { 'Content-Type' => 'application/json; charset=utf-8' }, [Release.all.to_json]]
    end
  end
end
