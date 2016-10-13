require 'release_notifier/version'
require 'release_notifier/release'

module ReleaseNotifier
  class Application
    def self.call(env)
      ['200', { 'Content-Type' => 'application/json; charset=utf-8' }, [Release.all.to_json]]
    end
  end
end
