require 'rails_helper'

RSpec.describe TimeEntry, :type => :model do
  context 'spent' do
    time = Time.now

    it 'should return time in seconds' do
      te = create(:time_entry, created_at: time, updated_at: time + 41)
      expect(te.spent).to eq('41 секунд')
    end

    it 'should return time in minutes and seconds' do
      te = create(:time_entry, created_at: time, updated_at: time + 81)
      expect(te.spent).to eq('1 минута, 21 секунд')
    end

    it 'should return time in minutes' do
      te = create(:time_entry, created_at: time, updated_at: time + 60)
      expect(te.spent).to eq('1 минута')
    end

    it 'should return time in hours, minutes and seconds' do
      te = create(:time_entry, created_at: time, updated_at: time + 3681)
      expect(te.spent).to eq('1 час, 1 минута, 21 секунд')
    end

    it 'should return time in hours' do
      te = create(:time_entry, created_at: time, updated_at: time + 3600)
      expect(te.spent).to eq('1 час')
    end
  end
end
