require 'rails_helper'

RSpec.describe Project, :type => :model do
  before :all do
    @project = create(:project_with_milestones)
  end

  context 'destroy' do

    it 'should have milestones and tasks' do
      expect(@project.milestones.count).to eq(5)
      expect(@project.milestones.last.tasks.count).to eq(5)
    end

    it 'should delete all dependent milestones and tasks' do
      @project.destroy!
      expect(Milestone.count).to eq(0)
      expect(Task.count).to eq(0)
    end

  end
end
