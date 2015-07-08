#statistic's page

class StatisticsController < ApplicationController
  def index
  	# a zero-initialized array to hold the RFP counts for each month
  	@months = Array.new(12,0)

  	#get all Oppty objects from database into the @oppties collection
  	@oppties = Oppty.all

	#iterate through all of the oppurtunities
  	@oppties.each do |opp|
  		#get month of this particular opportunity
  		month = opp.rfpDate.mon

  		#fill up the months array 
  		if month == 1 then @months[0]+=1 end
  		if month == 2 then @months[1]+=1 end
  		if month == 3 then @months[2]+=1 end
  		if month == 4 then @months[3]+=1 end
  		if month == 5 then @months[4]+=1 end
  		if month == 6 then @months[5]+=1 end
  		if month == 7 then @months[6]+=1 end
  		if month == 8 then @months[7]+=1 end
  		if month == 9 then @months[8]+=1 end
  		if month == 10 then @months[9]+=1 end
  		if month == 11 then @months[10]+=1 end
  		if month == 12 then @months[11]+=1 end
  	end
  	
  	#get all Oppty objects from database into the @oppties collection
  	@histories = History.all

	#iterate through all of the oppurtunities
  	@histories.each do |hist|
  		#get month of this particular opportunity
  		month = hist.rfpDate.mon

  		#fill up the months array 
  		if month == 1 then @months[0]+=1 end
  		if month == 2 then @months[1]+=1 end
  		if month == 3 then @months[2]+=1 end
  		if month == 4 then @months[3]+=1 end
  		if month == 5 then @months[4]+=1 end
  		if month == 6 then @months[5]+=1 end
  		if month == 7 then @months[6]+=1 end
  		if month == 8 then @months[7]+=1 end
  		if month == 9 then @months[8]+=1 end
  		if month == 10 then @months[9]+=1 end
  		if month == 11 then @months[10]+=1 end
  		if month == 12 then @months[11]+=1 end
  	end

  	#at this point @months has the RFP counts for each month
  end
end
