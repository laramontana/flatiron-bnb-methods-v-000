class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(requested_checkin, requested_checkout)
    @listings = []

    self.listings.each do |listing|

      @available_reservations = listing.reservations.select do |reservation|
          requested_checkin.to_date > reservation.checkout && requested_checkout.to_date < reservation.checkin
      end

      if !@available_reservations.empty?
        @listings << listing
      end
    end
    @listings
  end

end
#<Reservation:0x007fd2c2a3ea98
#  checkin: Fri, 25 Apr 2014,  Date Range A
#  checkout: Wed, 30 Apr 2014,
#
#  requested_checkin & checkout DateRange B
# => Thu, 01 May 2014
# => Mon, 05 May 2014
#
#   # Proof:
#   # Let ConditionA Mean that DateRange A Completely After DateRange B
#   # _                        |---- DateRange A ------|
#   # |---Date Range B -----|                           _
#   # (True if StartA > EndB)
#   #
#   # Let ConditionB Mean that DateRange A is Completely Before DateRange B
#   # |---- DateRange A -----|
#   25 Apr 2014          30 Apr 2014
#   #  _                          |---Date Range B ----|
#                            01 May 2014        Mon, 05 May 2014
#   # (True if EndA < StartB)

  # The #city_openings method should return all of the Listing objects that are available for the entire span that is inputted.
  # Check the resources below and try out a few things in console until you're satisfied with your solution.
  # Don't be afraid to google!
