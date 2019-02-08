require 'rails_helper'
require 'benchmark'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    it "is valid with a title, description" do
      task = Task.new(title: 'hello', description: 'helloworld')
      expect(task).to be_valid
    end

    it 'get title' do
      task = Task.new(title: 'hello', description: 'helloworld')
      expect(task.title).to eq 'hello'
    end

    it 'get description' do
      task = Task.new(title: 'hello', description: 'helloworld')
      expect(task.description).to eq 'helloworld'
    end

    it 'is not be valid without title' do
      task = Task.new(title: '', description: 'today')
      expect(task).not_to be_valid
    end

    it 'is not valid without description' do
      task = Task.new(title: 'today', description: '')
      expect(task).not_to be_valid
    end
  end

  describe '#search' do
    it "can search" do
      task1 = Task.create(id: 1, title: 'hello', description: 'hello')
      task2 = Task.create(id: 2, title: 'hellorspec', description: 'hello')
      task3 = Task.create(id: 3, title: 'hellorails', description: 'hello')
      task4 = Task.create(id: 4, title: 'helloruby', description: 'hello')
      expect(Task.search('rspec')).to include(task2)
      expect(Task.search('rspec')).to_not include(task1, task3, task4)
    end
    it "benchmark of add index to title" do
      99999.times{FactoryGirl.create(:task)}
      task = Task.create(title: 'hellorspec', description: 'hello')
      Benchmark.bm 10 do |r|
        r.report "add index" do
          Task.search('rspec')
        end
      end
    end
  end

end
