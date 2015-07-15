# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Oppty.delete_all
History.delete_all
UserOppty.delete_all
Oppty.create(opptyId: "1", opptyName:"test", idiqCA:"test", status2:"test", value:1, pWin:80,
  captureMgr:"test", programMgr:"test",  proposalMgr:"test", technicalLead:"test",sslOrg:"test", slArch:"test",
  ed:"test", on:"test", ate:"test", slComments:"test", rfpDate:"2015-07-01", awardDate:"2015-07-01",
  submitDate:"2015-07-01",  proposalDueDate:"2015-07-06", slDir:"testDir", leadEstim:"testLeadEst",
  engaged:"testEngaged", solution:"testSolution", estimate:"testEstimate")
Oppty.create(opptyId: "1", opptyName:"test1", idiqCA:"test1", status2:"test1", value:1, pWin:80,
             captureMgr:"test1", programMgr:"test1",  proposalMgr:"test11", technicalLead:"test1",sslOrg:"test",
             slArch:"test1",ed:"test1", on:"test1", ate:"test", slComments:"test1", rfpDate:"2015-07-01", awardDate:"2015-07-01",
             submitDate:"2015-07-01", proposalDueDate:"2015-07-07", slDir:"testDir1", leadEstim:"testLeadEst1",
             engaged:"testEngaged1", solution:"testSolution1", estimate:"testEstimate1")
Oppty.create(opptyId: "1", opptyName:"test2", idiqCA:"test2", status2:"test2", value:1, pWin:80,
             captureMgr:"test2", programMgr:"test2",  proposalMgr:"test2", technicalLead:"test2",sslOrg:"test2",
             slArch:"test2",ed:"test2", on:"test2", ate:"test2", slComments:"test2", rfpDate:"2015-07-01", awardDate:"2015-07-01",
             submitDate:"2015-07-01", proposalDueDate:"2015-07-08", slDir:"testDir2", leadEstim:"testLeadEst2",
             engaged:"testEngaged2", solution:"testSolution2", estimate:"testEstimate2")
