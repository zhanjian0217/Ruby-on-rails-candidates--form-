class VoteMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    VoteMailer.vote_notify('gian910147@gmail.com').deliver
  end
end
