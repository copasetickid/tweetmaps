When /^I reload the page$/ do
  visit [ current_path, page.driver.request.env['QUERY_STRING'] ].reject(&:blank?).join('?')
end

When /^the page reloads$/ do
  visit [ current_path, page.driver.request.env['QUERY_STRING'] ].reject(&:blank?).join('?')
end

When /I pry/ do
  binding.pry
end
