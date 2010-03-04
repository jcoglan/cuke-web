When /^I visit "([^\"]*)"$/ do |path|
  visit path
end

Then /^I should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end

