require 'rails_helper'
require 'benchmark'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    it "is valid with a title, description" do
      task = FactoryGirl.build(:task)
      expect(task).to be_valid
    end

    it 'get title' do
      user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
      task = Task.new(title: 'hello', description: 'helloworld', user_id: 1)
      expect(task.title).to eq 'hello'
    end

    it 'get description' do
      user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
      task = Task.new(title: 'hello', description: 'helloworld', user_id: 1)
      expect(task.description).to eq 'helloworld'
    end

    it 'is not be valid without title' do
      user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
      task = Task.new(title: '', description: 'today', user_id: 1)
      expect(task).not_to be_valid
    end

    it 'is not valid without description' do
      user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
      task = Task.new(title: 'today', description: '', user_id: 1)
      expect(task).not_to be_valid
    end
  end

  describe '#search' do
    it "can search" do
      task1 = FactoryGirl.create(:task, title: 'hello')
      task2 = FactoryGirl.create(:task, title: 'hellorspec')
      task3 = FactoryGirl.create(:task, title: 'hellorails')
      task4 = FactoryGirl.create(:task, title: 'helloruby')
      expect(Task.search('rspec')).to include(task2)
      expect(Task.search('rspec')).to_not include(task1, task3, task4)
    end
    # it "benchmark of add index to title" do
    # user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
    #   99999.times{FactoryGirl.create(:task)}
    #   task = Task.create(title: 'hellorspec', description: 'hello')
    #   Benchmark.bm 10 do |r|
    #     r.report "add index" do
    #       Task.search('rspec')
    #     end
    #   end
    # end
  end

end
