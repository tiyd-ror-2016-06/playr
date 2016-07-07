class CreepyJob < ActiveJob::Base
  queue_as :default

  def perform voice, word
    sleep rand
    system "say -v '#{voice}' '#{word}'"
  end
end
