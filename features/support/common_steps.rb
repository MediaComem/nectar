Given /^pending$/ do
  pending
end

Given "pending - reported by $who on $date" do |who, date|
  pending
end

Given /pending - (?!reported by)(.*)/ do |explanation|
  pending
end

When /we wait (\d+) second(s?)/ do |seconds, plural|
  sleep seconds.to_i
end


