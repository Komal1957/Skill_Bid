class RequestMailer < ApplicationMailer
    default from: "notifications@skillbid.com"

    # Client gets notified of a new bid
    def new_bid(request, bid)
        @request = request
        @bid = bid
        @client = request.user
        @freelancer = bid.user

        mail(to: @client.email, subject: "New Bid on '#{@request.title}'")
    end

    # Freelancer gets notified if they are no longer the lowest
    def outbid(request, current_bid)
        @request = request
        @bid = current_bid
        @user = current_bid.user

        mail(to: @user.email, subject: "You have been outbid on '#{@request.title}'")
    end

    # Winner notification (Used by the job later)
    def auction_won(request, bid)
        @request = request
        @bid = bid
        @freelancer = bid.user

        mail(to: @freelancer.email, subject: "Congratulations! You won the auction for '#{@request.title}'")
    end
end
