When /^I reject a contract$/ do
  @contract = @current_inventory_pool.orders.submitted.detect do |o|
    o.to_be_verified?
  end

  step %Q(I uncheck the "No verification required" button)

  @daily_view_line = find(".line[data-id='#{@contract.id}']")
  within @daily_view_line do
    find('.dropdown-toggle').click
    find('.red[data-order-reject]', text: _('Reject')).click
  end
end

When /^I reject this contract$/ do
  find("#daily-navigation button[data-order-reject][data-id='#{@contract.id}']").click
end

Then /^I see a summary of that contract$/ do
  within('.modal') do
    unless @contract.purpose.blank?
      find('p', text: @contract.purpose[0..25])
    end
  end
end

Then /^I can write a reason why I reject that contract$/ do
  find('#rejection-comment').set 'you are not allowed to get these things'
end

When /^I confirm the contract rejection$/ do
  within('.modal') do
    find('.button.red[type=submit]').click
  end
  step 'the modal is closed'
end

Then /^the contract is rejected$/ do
  sleep 1
  if @daily_view_line
    within @daily_view_line do
      find('.line-actions-column', text: _('Rejected'))
    end
  end

  expect(@contract.reload.state).to be == 'rejected'
  @contract.reservations.each do |line|
    if current_path == manage_contracts_path(@current_inventory_pool.id)
      find(".line.row", text: @contract.user.name).find('.line-actions-column', text: _('Rejected'))
    end
    expect(line.reload.status).to eq :rejected
  end
end

Then(/^I am redirected to the daily view$/) do
  expect(current_path).to eq manage_daily_view_path(@current_inventory_pool)
end
