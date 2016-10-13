require 'release_notifier/version'
require 'release_notifier/changelog'

module ReleaseNotifier
  class Application
    def self.call(env)
      ['200', { 'Content-Type' => 'application/json' }, [Changelog.all.to_json]]
    end
  end
end
