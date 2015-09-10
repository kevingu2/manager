#statistic's page

class StatisticsController < ApplicationController
  def index
    #get all Opportunity objects from database into the @oppties collection
    @oppties = Oppty.all
    #get all History objects from database into the @histories collection
    @histories = History.all

    @allYears = Array.new
    #iterate through all opportunities and get the year of rfp's and add it to allYears array
    @oppties.each do |n|
      if !n.rfpDate.nil?
        unless @allYears.include?(n.rfpDate.year)
          @allYears.push(n.rfpDate.year)
        end
      end
    end
    @histories.each do |n|
      if !n.rfpDate.nil?
        unless @allYears.include?(n.rfpDate.year)
          @allYears.push(n.rfpDate.year)
        end
      end
    end
    #sort the @allYears array
    @allYears = @allYears.sort

    #creating arrays
    @rfpMonths = Array.new(12,0)
    @allRFPMonths = Array.new
    @milMonths = Array.new(12,0)
    @allMilMonths = Array.new
    #iterat through all years and create a zero-initialized arrays for each year
    (0..@allYears.length).each do |i|
      # a zero-initialized array to hold the RFP counts for months for each year
      @allRFPMonths[i] = Array.new(12,0)
    end

    @oppties.each do |n|
      #get month and year of each particular opportunity
      if !n.rfpDate.nil?
        month = n.rfpDate.mon
        year = n.rfpDate.year

        #fill up the rfpMonths array 
        @rfpMonths[month-1] += 1

        (0..@allYears.length).each do |i|
          #fill up the rfpMonths arrays
          if year == @allYears[i] then @allRFPMonths[i][month-1] += 1 end
        end
      end
    end
  	
	  #iterate through all of the histories
    @histories.each do |hist|
  		#get month and year of each particular history
      if !hist.rfpDate.nil?
        month = hist.rfpDate.mon
        year = hist.rfpDate.year

        #fill up the rfpMonths array 
        @rfpMonths[month-1] += 1

        (0..@allYears.length).each do |i|
          #fill up the rfpMonths arrays
          if year == @allYears[i] then @allRFPMonths[i][month-1] += 1 end
        end
      end
    end

    #at this point @rfpMonths has the RFP counts for each month

    @allYearsMil = Array.new
    #iterate through all opportunities and get the year of rfp's and add it to allYears array
    @oppties.each do |n|
      if !n.awardDate.nil? and n.status2 == 'W1-Won'
        unless @allYearsMil.include?(n.awardDate.year)
          @allYearsMil.push(n.awardDate.year)
        end
      end
    end
    @histories.each do |n|
      if !n.awardDate.nil? and n.status2 == 'W1-Won'
        unless @allYearsMil.include?(n.awardDate.year)
          @allYearsMil.push(n.awardDate.year)
        end
      end
    end
    #sort the @allYears array
    @allYearsMil = @allYearsMil.sort

    #creating arrays
    @milMonths = Array.new(12,0)
    @allMilMonths = Array.new

    #iterat through all years and create a zero-initialized arrays for each year
    (0..@allYearsMil.length).each do |i|
      # a zero-initialized array to hold the mil counts for months for each year
      @allMilMonths[i] = Array.new(12,0)
    end

    @oppties.each do |n|
      if !n.awardDate.nil?
        month1 = n.awardDate.mon
        year1 = n.awardDate.year
        valid1 = n.status2

        #fill up the milMonths arrays 
        if n.value != nil and valid1 == 'W1-Won' then
          #fill up the milMonths array 
          @milMonths[month1-1] += n.value

          (0..@allYearsMil.length).each do |i|
            #fill up the milMonths arrays
            if year1 == @allYearsMil[i] then @allMilMonths[i][month1-1] += n.value end
          end
        end
      end
    end
    
    #iterate through all of the histories
    @histories.each do |hist|
      if !hist.awardDate.nil?
        #get month of this particular opportunity
        month1 = hist.awardDate.mon
        year1 = hist.awardDate.year
        valid1 = hist.status2

        #fill up the milMonths arrays 
        if hist.value != nil and valid1 == 'W1-Won' then
          #fill up the milMonths array 
          @milMonths[month1-1] += hist.value

          (0..@allYearsMil.length).each do |i|
            #fill up the rfpMonths arrays
            if year1 == @allYearsMil[i] then @allRFPMonths[i][month1-1] += hist.value end
          end
        end
      end
    end


    #at this point @milMonths has the millions of $ counts for each month

    
    (0..11).each do |i|
      @milMonths[i] = ( @milMonths[i] * 10.0).round / 10.0
      (0..@allYearsMil.length).each do |l|
        if @allMilMonths[i] != nil
          @allMilMonths[i][l] = ( @allMilMonths[i][l] * 10.0).round / 10.0
        end
      end
    end
    #at this point @milMonths is now rounded to 1 precision point
  end
end
