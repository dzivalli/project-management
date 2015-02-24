require 'rails_helper'

RSpec.describe Project, :type => :model do
  # before :all do
  #   @project = create(:project_with_milestones_and_tasks)
  # end
  #
  # context 'destroy' do
  #   it 'should have milestones and tasks' do
  #     expect(@project.milestones.count).to eq(5)
  #     expect(@project.milestones.last.tasks.count).to eq(5)
  #   end
  #
  #   it 'should delete all dependent milestones and tasks' do
  #     @project.destroy!
  #     expect(Milestone.count).to eq(0)
  #     expect(Task.count).to eq(0)
  #   end
  # end
  #
  # context 'active_tasks' do
  #   it 'should return all active tasks' do
  #     user = create(:admin)
  #     te = create(:active_time_entry, user: user)
  #     # @project.tasks.last.time_entries << te
  #     expect(@project.tasks.count).to eq(25)
  #     expect(@project.active_tasks(user).count).to be > 0
  #   end
  # end

  context 'progres' do
    before :all do
      @time = Time.now
      @project = create(:project, estimated_hours: 1)
    end

    it 'should return 100%' do
      create(:completed_time_entry, project: @project, created_at: @time, updated_at: @time + 3600)
      expect(@project.progres).to eq(100)
    end

    it 'should return 0%' do
      create(:completed_time_entry, project: @project, created_at: @time)
      expect(@project.progres).to eq(0)
    end

    it 'should return 0 if there are no time entry' do
      expect(@project.progres).to eq(0)
    end

    it 'should return 100% if estimated_hours == nil or 0' do
      @project.estimated_hours = nil
      expect(@project.progres).to eq(100)

      @project.estimated_hours = 0
      expect(@project.progres).to eq(100)
    end



  end

end
