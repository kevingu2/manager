json.array!(@oppties) do |oppty|
  json.extract! oppty, :id, :opptyId, :opptyName, :idiqCA, :status2, :value, :pWin, :captureMgr, :programMgr, :proposalMgr, :sslOrg, :technicalLead, :sslArch, :ed, :on, :ate, :slComments, :rfpDate, :awardDate, :submitDate, :numWriters
  json.url oppty_url(oppty, format: :json)
end
