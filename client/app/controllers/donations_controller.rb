class DonationsController < ApplicationController
    def new
        donation = Donation.find(params[:pledger_id])
    end
end
