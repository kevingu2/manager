# CRM Manager

Server URL = interos.saicwebhost.net

Port = 3000

##1. Introduction
This website allows managers to upload .xlsm files with a list of all the opportunities. They can then assign employees to specific opportunity and gain an oversight of how resources are being allocated on the opportunities.

###1.1 Overview functionalities

####1.1.1 Creating an Account
	1.	The initial page is the login page.
	2.	The user then is able to click on a signup button which redirects them to the sign up page.
	3.	The user provides an username that is not taken, password, and a role (writer or manager).
	
####1.1.2 Manager
	1.	The manager is able to upload .xlsm file in the CRM page. It will tell the manager how many opportunity will be added, updated, deleted, and are the same. Then they will be able to submit the file.
	2.	The browse page will display all the opportunities that has been added through the .xlsm file.
	3.	The manager will then be able to search through the browse page, assign employees to the opportunity, and edit specific information of the opportunity.
	4.	After the manager assigns the employees to work on certain opportunity, he/she can then view the progress of the employees on the allocated tasks page and remove them from certain opportunities.
	5. 	The manager is also able to view all the opportunities that they have been deleted in the history page.
	6.	The statistics displays the opportunities by their RFP dates in a bar graph format
	
####1.1.3 Writer
	1.	The writer can see the tasks they have been assigned to work on in their task page. They can drag and drop them to todo, doing, and done sections to show their work progress.
	2.	They can also view the browse page and add opportunities they want to work on. 
	3. 	Their history page show only opportunities that have been deleted and they had worked on.
	
##2. Getting Started

###2.1 List of Requirements
1. [Ruby](https://www.ruby-lang.org/en/)
2. [Rails](http://rubyonrails.org/)
3. [Python](https://www.python.org/)

###2.2 Instructions
**Step 1:** Access the bitbucket CRM Manager repository of SAIC

**Step 2:** Install [Rails Installer](http://railsinstaller.org/en) which includes the updated version of Ruby

**step 3:** Install Rails

**Step 4:** Go into the project directory and run "rake db:mgirate" to set up the database

**Step 5:** Run "rake test test" and make sure all the tests pass

**Step 6:** Run "rail s" to start the rails server

**Step 7:** Go to localhost:3000 in your browser and you should see the login page

