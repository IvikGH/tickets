module Helpers

  def generate_standart_statuses
    FactoryGirl.create(:status, title: 'Waiting for Customer')
    FactoryGirl.create(:status, title: 'On Hold')
    FactoryGirl.create(:status, title: 'Cancelled')
    FactoryGirl.create(:status, title: 'Completed')
  end
end
