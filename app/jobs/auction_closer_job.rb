class AuctionCloserJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # 1. Find all requests that are OPEN but have expired
    expired_requests = Request.open.where("expires_at < ?", Time.current)

    expired_requests.find_each do |request|
      # 2. Close the request
      request.update!(status: :closed)

      # 3. Find the lowest bid (The Winner)
      winning_bid = request.bids.order(amount: :asc).first

      if winning_bid
        # 4. Email the winner
        RequestMailer.with(request: request, bid: winning_bid).auction_won.deliver_later

        # Note: In a real payment app, this is where you'd create a Transaction record
        puts "Auction closed for Request ##{request.id}. Winner: #{winning_bid.user.email}"
      else
        puts "Auction closed for Request ##{request.id}. No bids placed."
      end
    end
  end
end
