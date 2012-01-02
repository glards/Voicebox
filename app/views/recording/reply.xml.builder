xml.instruct!
xml.Response do
  if @valid
    xml.Record(action: url_for(action: 'callback', only_path: false),
               timeout: 10,
               maxLength: 120)
  else
    xml.Reject
  end
end
