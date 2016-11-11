client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

client.on :message do |data|
  text = data.text
  email = client.users[data.user].profile.email
  date = DateTime.now.beginning_of_day
  amount = 8 * 60

  date_regex = /^(20\d{2})(\/|-)((0|1)+\d)(\/|-)([0-3]\d)/
  amount_regex = /^(\d+(\.?\d?)(hours?|h)?)/i

  date_matches = date_regex.match text
  if date_matches
    date = Date.parse(date_matches[0])
    text = text.gsub(date_regex, '')
    text.strip!
  end

  amount_matches = amount_regex.match text
  if amount_matches
    amount = amount_matches[0].gsub(/hours?|h/i, '').to_f * 60
    text = text.gsub(amount_regex, '')
    text.strip!
  end

  project = Project.find_by_name(text)
  if project
    user = User.where({ email: email }).first_or_create
    day = user.days.where({ date: date }).first_or_create
    day.update({
      time_records_attributes: [{ project_id: project.id, amount: amount }]
    })
    client.message channel: data.channel, text: "Date: *#{date.strftime('%Y-%m-%d')}*, Time: *#{amount}*, Project: *#{project.name}*"
  else
    client.message channel: data.channel, text: "Sorry <@#{data.user}>, can't find project `#{text}`"
  end
end

client.on :close do |_data|
  puts "Client is about to disconnect"
end

client.on :closed do |_data|
  puts "Client has disconnected successfully!"
end

client.start!
