#statistic's page

class StatisticsController < ApplicationController
  def index
  	# a zero-initialized array to hold the RFP counts for each month
  	@rfpMonths = Array.new(12,0)
    # a zero-initialized array to hold the mil counts for each month
    @milMonths = Array.new(12,0)

  	#get all Oppty objects from database into the @oppties collection
  	@oppties = Oppty.all

	  #iterate through all of the oppurtunities
  	@oppties.each do |opp|
  		#get month of this particular opportunity
  		month = opp.rfpDate.mon

  		#fill up the rfpMonths array 
  		if month == 1 then @rfpMonths[0]+=1 end
  		if month == 2 then @rfpMonths[1]+=1 end
  		if month == 3 then @rfpMonths[2]+=1 end
  		if month == 4 then @rfpMonths[3]+=1 end
  		if month == 5 then @rfpMonths[4]+=1 end
  		if month == 6 then @rfpMonths[5]+=1 end
  		if month == 7 then @rfpMonths[6]+=1 end
  		if month == 8 then @rfpMonths[7]+=1 end
  		if month == 9 then @rfpMonths[8]+=1 end
  		if month == 10 then @rfpMonths[9]+=1 end
  		if month == 11 then @rfpMonths[10]+=1 end
  		if month == 12 then @rfpMonths[11]+=1 end
  	end
  	
  	#get all Oppty objects from database into the @oppties collection
  	@histories = History.all

	  #iterate through all of the oppurtunities
  	@histories.each do |hist|
  		#get month of this particular opportunity
  		month = hist.rfpDate.mon

  		#fill up the rfpMonths array 
  		if month == 1 then @rfpMonths[0]+=1 end
  		if month == 2 then @rfpMonths[1]+=1 end
  		if month == 3 then @rfpMonths[2]+=1 end
  		if month == 4 then @rfpMonths[3]+=1 end
  		if month == 5 then @rfpMonths[4]+=1 end
  		if month == 6 then @rfpMonths[5]+=1 end
  		if month == 7 then @rfpMonths[6]+=1 end
  		if month == 8 then @rfpMonths[7]+=1 end
  		if month == 9 then @rfpMonths[8]+=1 end
  		if month == 10 then @rfpMonths[9]+=1 end
  		if month == 11 then @rfpMonths[10]+=1 end
  		if month == 12 then @rfpMonths[11]+=1 end
  	end

    #at this point @milMonths has the RFP counts for each month

    #iterate through all of the oppurtunities
    @oppties.each do |opp|
      #get month of this particular opportunity
      month = opp.rfpDate.mon

      #fill up the milMonths array 
      unless opp.value == nil then
        if month == 1 then @milMonths[0]+=opp.value end
        if month == 2 then @milMonths[1]+=opp.value end
        if month == 3 then @milMonths[2]+=opp.value end
        if month == 4 then @milMonths[3]+=opp.value end
        if month == 5 then @milMonths[4]+=opp.value end
        if month == 6 then @milMonths[5]+=opp.value end
        if month == 7 then @milMonths[6]+=opp.value end
        if month == 8 then @milMonths[7]+=opp.value end
        if month == 9 then @milMonths[8]+=opp.value end
        if month == 10 then @milMonths[9]+=opp.value end
        if month == 11 then @milMonths[10]+=opp.value end
        if month == 12 then @milMonths[11]+=opp.value end
      end
    end
    
    #get all Oppty objects from database into the @oppties collection
    @histories = History.all

    #iterate through all of the oppurtunities
    @histories.each do |hist|
      #get month of this particular opportunity
      month = hist.awardDate.mon

      #fill up the milMonths array 
      unless hist.value == nil then
        if month == 1 then @milMonths[0]+=hist.value end
        if month == 2 then @milMonths[1]+=hist.value end
        if month == 3 then @milMonths[2]+=hist.value end
        if month == 4 then @milMonths[3]+=hist.value end
        if month == 5 then @milMonths[4]+=hist.value end
        if month == 6 then @milMonths[5]+=hist.value end
        if month == 7 then @milMonths[6]+=hist.value end
        if month == 8 then @milMonths[7]+=hist.value end
        if month == 9 then @milMonths[8]+=hist.value end
        if month == 10 then @milMonths[9]+=hist.value end
        if month == 11 then @milMonths[10]+=hist.value end
        if month == 12 then @milMonths[11]+=hist.value end
      end
    end
  	
    #at this point @milMonths has the millions of $ counts for each month

    @milMonths[0] = ( @milMonths[0] * 10.0).round / 10.0
    @milMonths[1] = ( @milMonths[1] * 10.0).round / 10.0
    @milMonths[2] = ( @milMonths[2] * 10.0).round / 10.0
    @milMonths[3] = ( @milMonths[3] * 10.0).round / 10.0
    @milMonths[4] = ( @milMonths[4] * 10.0).round / 10.0
    @milMonths[5] = ( @milMonths[5] * 10.0).round / 10.0
    @milMonths[6] = ( @milMonths[6] * 10.0).round / 10.0
    @milMonths[7] = ( @milMonths[7] * 10.0).round / 10.0
    @milMonths[8] = ( @milMonths[8] * 10.0).round / 10.0
    @milMonths[9] = ( @milMonths[9] * 10.0).round / 10.0
    @milMonths[10] = ( @milMonths[10] * 10.0).round / 10.0
    @milMonths[11] = ( @milMonths[11] * 10.0).round / 10.0

    #at this point @milMonths is now rounded to 1 precision point
  end
end
