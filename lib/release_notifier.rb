require 'release_notifier/version'
require 'release_notifier/changelog'

module ReleaseNotifier
  class Application
    def self.call(env)
      ['200', {}, ['Hello from release_notifier']]
    end
  end
end
