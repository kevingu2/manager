#statistic's page

class StatisticsController < ApplicationController
  def index
  	# a zero-initialized array to hold the RFP counts for months for each year
  	@rfpMonths = Array.new(12,0)
    @rfpMonths2014 = Array.new(12,0)
    @rfpMonths2015 = Array.new(12,0)
    @rfpMonths2016 = Array.new(12,0)
    # a zero-initialized array to hold the mil counts for months for each year
    @milMonths = Array.new(12,0)
    @milMonths2014 = Array.new(12,0)
    @milMonths2015 = Array.new(12,0)
    @milMonths2016 = Array.new(12,0) 

  	#get all Oppty objects from database into the @oppties collection
  	@oppties = Oppty.all

	  #iterate through all of the oppurtunities
  	@oppties.each do |opp|
  		#get month of this particular opportunity
  		month = opp.rfpDate.mon
      year = opp.rfpDate.year

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

      if month == 1 and year == 2014 then @rfpMonths2014[0]+=1 end
      if month == 2 and year == 2014 then @rfpMonths2014[1]+=1 end
      if month == 3 and year == 2014 then @rfpMonths2014[2]+=1 end
      if month == 4 and year == 2014 then @rfpMonths2014[3]+=1 end
      if month == 5 and year == 2014 then @rfpMonths2014[4]+=1 end
      if month == 6 and year == 2014 then @rfpMonths2014[5]+=1 end
      if month == 7 and year == 2014 then @rfpMonths2014[6]+=1 end
      if month == 8 and year == 2014 then @rfpMonths2014[7]+=1 end
      if month == 9 and year == 2014 then @rfpMonths2014[8]+=1 end
      if month == 10 and year == 2014 then @rfpMonths2014[9]+=1 end
      if month == 11 and year == 2014 then @rfpMonths2014[10]+=1 end
      if month == 12 and year == 2014 then @rfpMonths2014[11]+=1 end

      if month == 1 and year == 2015 then @rfpMonths2015[0]+=1 end
      if month == 2 and year == 2015 then @rfpMonths2015[1]+=1 end
      if month == 3 and year == 2015 then @rfpMonths2015[2]+=1 end
      if month == 4 and year == 2015 then @rfpMonths2015[3]+=1 end
      if month == 5 and year == 2015 then @rfpMonths2015[4]+=1 end
      if month == 6 and year == 2015 then @rfpMonths2015[5]+=1 end
      if month == 7 and year == 2015 then @rfpMonths2015[6]+=1 end
      if month == 8 and year == 2015 then @rfpMonths2015[7]+=1 end
      if month == 9 and year == 2015 then @rfpMonths2015[8]+=1 end
      if month == 10 and year == 2015 then @rfpMonths2015[9]+=1 end
      if month == 11 and year == 2015 then @rfpMonths2015[10]+=1 end
      if month == 12 and year == 2015 then @rfpMonths2015[11]+=1 end

      if month == 1 and year == 2016 then @rfpMonths2016[0]+=1 end
      if month == 2 and year == 2016 then @rfpMonths2016[1]+=1 end
      if month == 3 and year == 2016 then @rfpMonths2016[2]+=1 end
      if month == 4 and year == 2016 then @rfpMonths2016[3]+=1 end
      if month == 5 and year == 2016 then @rfpMonths2016[4]+=1 end
      if month == 6 and year == 2016 then @rfpMonths2016[5]+=1 end
      if month == 7 and year == 2016 then @rfpMonths2016[6]+=1 end
      if month == 8 and year == 2016 then @rfpMonths2016[7]+=1 end
      if month == 9 and year == 2016 then @rfpMonths2016[8]+=1 end
      if month == 10 and year == 2016 then @rfpMonths2016[9]+=1 end
      if month == 11 and year == 2016 then @rfpMonths2016[10]+=1 end
      if month == 12 and year == 2016 then @rfpMonths2016[11]+=1 end
  	end
  	
  	#get all Oppty objects from database into the @oppties collection
  	@histories = History.all

	  #iterate through all of the oppurtunities
  	@histories.each do |hist|
  		#get month of this particular opportunity
  		month = hist.rfpDate.mon
      year = hist.rfpDate.year

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

      if month == 1 and year == 2014 then @rfpMonths2014[0]+=1 end
      if month == 2 and year == 2014 then @rfpMonths2014[1]+=1 end
      if month == 3 and year == 2014 then @rfpMonths2014[2]+=1 end
      if month == 4 and year == 2014 then @rfpMonths2014[3]+=1 end
      if month == 5 and year == 2014 then @rfpMonths2014[4]+=1 end
      if month == 6 and year == 2014 then @rfpMonths2014[5]+=1 end
      if month == 7 and year == 2014 then @rfpMonths2014[6]+=1 end
      if month == 8 and year == 2014 then @rfpMonths2014[7]+=1 end
      if month == 9 and year == 2014 then @rfpMonths2014[8]+=1 end
      if month == 10 and year == 2014 then @rfpMonths2014[9]+=1 end
      if month == 11 and year == 2014 then @rfpMonths2014[10]+=1 end
      if month == 12 and year == 2014 then @rfpMonths2014[11]+=1 end

      if month == 1 and year == 2015 then @rfpMonths2015[0]+=1 end
      if month == 2 and year == 2015 then @rfpMonths2015[1]+=1 end
      if month == 3 and year == 2015 then @rfpMonths2015[2]+=1 end
      if month == 4 and year == 2015 then @rfpMonths2015[3]+=1 end
      if month == 5 and year == 2015 then @rfpMonths2015[4]+=1 end
      if month == 6 and year == 2015 then @rfpMonths2015[5]+=1 end
      if month == 7 and year == 2015 then @rfpMonths2015[6]+=1 end
      if month == 8 and year == 2015 then @rfpMonths2015[7]+=1 end
      if month == 9 and year == 2015 then @rfpMonths2015[8]+=1 end
      if month == 10 and year == 2015 then @rfpMonths2015[9]+=1 end
      if month == 11 and year == 2015 then @rfpMonths2015[10]+=1 end
      if month == 12 and year == 2015 then @rfpMonths2015[11]+=1 end

      if month == 1 and year == 2016 then @rfpMonths2016[0]+=1 end
      if month == 2 and year == 2016 then @rfpMonths2016[1]+=1 end
      if month == 3 and year == 2016 then @rfpMonths2016[2]+=1 end
      if month == 4 and year == 2016 then @rfpMonths2016[3]+=1 end
      if month == 5 and year == 2016 then @rfpMonths2016[4]+=1 end
      if month == 6 and year == 2016 then @rfpMonths2016[5]+=1 end
      if month == 7 and year == 2016 then @rfpMonths2016[6]+=1 end
      if month == 8 and year == 2016 then @rfpMonths2016[7]+=1 end
      if month == 9 and year == 2016 then @rfpMonths2016[8]+=1 end
      if month == 10 and year == 2016 then @rfpMonths2016[9]+=1 end
      if month == 11 and year == 2016 then @rfpMonths2016[10]+=1 end
      if month == 12 and year == 2016 then @rfpMonths2016[11]+=1 end
  	end

    #at this point @rfpMonths has the RFP counts for each month

    #iterate through all of the oppurtunities
    @oppties.each do |opp|
      #get month of this particular opportunity
      month = opp.awardDate.mon
      year = opp.awardDate.year

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

        if month == 1 and year == 2014 then @milMonths2014[0]+=opp.value end
        if month == 2 and year == 2014 then @milMonths2014[1]+=opp.value end
        if month == 3 and year == 2014 then @milMonths2014[2]+=opp.value end
        if month == 4 and year == 2014 then @milMonths2014[3]+=opp.value end
        if month == 5 and year == 2014 then @milMonths2014[4]+=opp.value end
        if month == 6 and year == 2014 then @milMonths2014[5]+=opp.value end
        if month == 7 and year == 2014 then @milMonths2014[6]+=opp.value end
        if month == 8 and year == 2014 then @milMonths2014[7]+=opp.value end
        if month == 9 and year == 2014 then @milMonths2014[8]+=opp.value end
        if month == 10 and year == 2014 then @milMonths2014[9]+=opp.value end
        if month == 11 and year == 2014 then @milMonths2014[10]+=opp.value end
        if month == 12 and year == 2014 then @milMonths2014[11]+=opp.value end

        if month == 1 and year == 2015 then @milMonths2015[0]+=opp.value end
        if month == 2 and year == 2015 then @milMonths2015[1]+=opp.value end
        if month == 3 and year == 2015 then @milMonths2015[2]+=opp.value end
        if month == 4 and year == 2015 then @milMonths2015[3]+=opp.value end
        if month == 5 and year == 2015 then @milMonths2015[4]+=opp.value end
        if month == 6 and year == 2015 then @milMonths2015[5]+=opp.value end
        if month == 7 and year == 2015 then @milMonths2015[6]+=opp.value end
        if month == 8 and year == 2015 then @milMonths2015[7]+=opp.value end
        if month == 9 and year == 2015 then @milMonths2015[8]+=opp.value end
        if month == 10 and year == 2015 then @milMonths2015[9]+=opp.value end
        if month == 11 and year == 2015 then @milMonths2015[10]+=opp.value end
        if month == 12 and year == 2015 then @milMonths2015[11]+=opp.value end

        if month == 1 and year == 2016 then @milMonths2016[0]+=opp.value end
        if month == 2 and year == 2016 then @milMonths2016[1]+=opp.value end
        if month == 3 and year == 2016 then @milMonths2016[2]+=opp.value end
        if month == 4 and year == 2016 then @milMonths2016[3]+=opp.value end
        if month == 5 and year == 2016 then @milMonths2016[4]+=opp.value end
        if month == 6 and year == 2016 then @milMonths2016[5]+=opp.value end
        if month == 7 and year == 2016 then @milMonths2016[6]+=opp.value end
        if month == 8 and year == 2016 then @milMonths2016[7]+=opp.value end
        if month == 9 and year == 2016 then @milMonths2016[8]+=opp.value end
        if month == 10 and year == 2016 then @milMonths2016[9]+=opp.value end
        if month == 11 and year == 2016 then @milMonths2016[10]+=opp.value end
        if month == 12 and year == 2016 then @milMonths2016[11]+=opp.value end
      end
    end

    #iterate through all of the oppurtunities
    @histories.each do |hist|
      #get month of this particular opportunity
      month = hist.awardDate.mon
      year = hist.awardDate.year

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

        if month == 1 and year == 2014 then @milMonths2014[0]+=hist.value end
        if month == 2 and year == 2014 then @milMonths2014[1]+=hist.value end
        if month == 3 and year == 2014 then @milMonths2014[2]+=hist.value end
        if month == 4 and year == 2014 then @milMonths2014[3]+=hist.value end
        if month == 5 and year == 2014 then @milMonths2014[4]+=hist.value end
        if month == 6 and year == 2014 then @milMonths2014[5]+=hist.value end
        if month == 7 and year == 2014 then @milMonths2014[6]+=hist.value end
        if month == 8 and year == 2014 then @milMonths2014[7]+=hist.value end
        if month == 9 and year == 2014 then @milMonths2014[8]+=hist.value end
        if month == 10 and year == 2014 then @milMonths2014[9]+=hist.value end
        if month == 11 and year == 2014 then @milMonths2014[10]+=hist.value end
        if month == 12 and year == 2014 then @milMonths2014[11]+=hist.value end

        if month == 1 and year == 2015 then @milMonths2015[0]+=hist.value end
        if month == 2 and year == 2015 then @milMonths2015[1]+=hist.value end
        if month == 3 and year == 2015 then @milMonths2015[2]+=hist.value end
        if month == 4 and year == 2015 then @milMonths2015[3]+=hist.value end
        if month == 5 and year == 2015 then @milMonths2015[4]+=hist.value end
        if month == 6 and year == 2015 then @milMonths2015[5]+=hist.value end
        if month == 7 and year == 2015 then @milMonths2015[6]+=hist.value end
        if month == 8 and year == 2015 then @milMonths2015[7]+=hist.value end
        if month == 9 and year == 2015 then @milMonths2015[8]+=hist.value end
        if month == 10 and year == 2015 then @milMonths2015[9]+=hist.value end
        if month == 11 and year == 2015 then @milMonths2015[10]+=hist.value end
        if month == 12 and year == 2015 then @milMonths2015[11]+=hist.value end

        if month == 1 and year == 2016 then @milMonths2016[0]+=hist.value end
        if month == 2 and year == 2016 then @milMonths2016[1]+=hist.value end
        if month == 3 and year == 2016 then @milMonths2016[2]+=hist.value end
        if month == 4 and year == 2016 then @milMonths2016[3]+=hist.value end
        if month == 5 and year == 2016 then @milMonths2016[4]+=hist.value end
        if month == 6 and year == 2016 then @milMonths2016[5]+=hist.value end
        if month == 7 and year == 2016 then @milMonths2016[6]+=hist.value end
        if month == 8 and year == 2016 then @milMonths2016[7]+=hist.value end
        if month == 9 and year == 2016 then @milMonths2016[8]+=hist.value end
        if month == 10 and year == 2016 then @milMonths2016[9]+=hist.value end
        if month == 11 and year == 2016 then @milMonths2016[10]+=hist.value end
        if month == 12 and year == 2016 then @milMonths2016[11]+=hist.value end
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

    @milMonths2014[0] = ( @milMonths2014[0] * 10.0).round / 10.0
    @milMonths2014[1] = ( @milMonths2014[1] * 10.0).round / 10.0
    @milMonths2014[2] = ( @milMonths2014[2] * 10.0).round / 10.0
    @milMonths2014[3] = ( @milMonths2014[3] * 10.0).round / 10.0
    @milMonths2014[4] = ( @milMonths2014[4] * 10.0).round / 10.0
    @milMonths2014[5] = ( @milMonths2014[5] * 10.0).round / 10.0
    @milMonths2014[6] = ( @milMonths2014[6] * 10.0).round / 10.0
    @milMonths2014[7] = ( @milMonths2014[7] * 10.0).round / 10.0
    @milMonths2014[8] = ( @milMonths2014[8] * 10.0).round / 10.0
    @milMonths2014[9] = ( @milMonths2014[9] * 10.0).round / 10.0
    @milMonths2014[10] = ( @milMonths2014[10] * 10.0).round / 10.0
    @milMonths2014[11] = ( @milMonths2014[11] * 10.0).round / 10.0

    @milMonths2015[0] = ( @milMonths2015[0] * 10.0).round / 10.0
    @milMonths2015[1] = ( @milMonths2015[1] * 10.0).round / 10.0
    @milMonths2015[2] = ( @milMonths2015[2] * 10.0).round / 10.0
    @milMonths2015[3] = ( @milMonths2015[3] * 10.0).round / 10.0
    @milMonths2015[4] = ( @milMonths2015[4] * 10.0).round / 10.0
    @milMonths2015[5] = ( @milMonths2015[5] * 10.0).round / 10.0
    @milMonths2015[6] = ( @milMonths2015[6] * 10.0).round / 10.0
    @milMonths2015[7] = ( @milMonths2015[7] * 10.0).round / 10.0
    @milMonths2015[8] = ( @milMonths2015[8] * 10.0).round / 10.0
    @milMonths2015[9] = ( @milMonths2015[9] * 10.0).round / 10.0
    @milMonths2015[10] = ( @milMonths2015[10] * 10.0).round / 10.0
    @milMonths2015[11] = ( @milMonths2015[11] * 10.0).round / 10.0

    @milMonths2016[0] = ( @milMonths2016[0] * 10.0).round / 10.0
    @milMonths2016[1] = ( @milMonths2016[1] * 10.0).round / 10.0
    @milMonths2016[2] = ( @milMonths2016[2] * 10.0).round / 10.0
    @milMonths2016[3] = ( @milMonths2016[3] * 10.0).round / 10.0
    @milMonths2016[4] = ( @milMonths2016[4] * 10.0).round / 10.0
    @milMonths2016[5] = ( @milMonths2016[5] * 10.0).round / 10.0
    @milMonths2016[6] = ( @milMonths2016[6] * 10.0).round / 10.0
    @milMonths2016[7] = ( @milMonths2016[7] * 10.0).round / 10.0
    @milMonths2016[8] = ( @milMonths2016[8] * 10.0).round / 10.0
    @milMonths2016[9] = ( @milMonths2016[9] * 10.0).round / 10.0
    @milMonths2016[10] = ( @milMonths2016[10] * 10.0).round / 10.0
    @milMonths2016[11] = ( @milMonths2016[11] * 10.0).round / 10.0

    #at this point @milMonths is now rounded to 1 precision point
  end
end
