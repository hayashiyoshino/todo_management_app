require 'rails_helper'

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


end
