When /^I visit "([^\"]*)"$/ do |path|
  visit path
end

Then /^I should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "([^\"]*)"$/ do |text|
  page.should_not have_content(text)
end

When /^I follow "(.*)"$/ do |link_text|
  click link_text
end

Then /^I should see$/ do |string|
  page.should have_content(string)
end

