require 'rails_helper'

RSpec.describe Milestone, :type => :model do
  context 'progress' do
    it 'should return correct progress' do
      time = Time.now
      milestone = create(:milestone)
      task = create(:task, milestone: milestone, estimated_hours: 1)
      create(:completed_time_entry, task: task, created_at: time, updated_at: time + 3600)

      expect(milestone.progress).to eq(100)
    end
  end
end

