require 'rails_helper'

feature 'Task管理' do

  scenario "期限が近い順で並び替えができていること" do
    4.times { FactoryGirl.create(:task) }
    visit tasks_path
    click_on '期限近い順で並べ替え'
    tasks = all('.task_item')
    expect(tasks[0]).to have_content "task1"
    expect(tasks[1]).to have_content "task2"
    expect(tasks[2]).to have_content "task3"
    expect(tasks[3]).to have_content "task4"
  end

  scenario "期限が遠い順で並び替えができていること" do
    4.times { FactoryGirl.create(:task) }
    visit tasks_path
    click_on '期限遠い順で並べ替え'
    tasks = all('.task_item')
    expect(tasks[0]).to have_content "task8"
    expect(tasks[1]).to have_content "task7"
    expect(tasks[2]).to have_content "task6"
    expect(tasks[3]).to have_content "task5"
  end

  scenario "作成日時の順番で並び替えができていること" do
    4.times { FactoryGirl.create(:task) }
    visit tasks_path
    tasks = all('.task_item')
    expect(tasks[0]).to have_content "9"
  end

  scenario "Taskの新規作成時にtitleが''だとエラーが表示される" do
    user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
    visit tasks_path
    click_link '新規作成'
    fill_in 'Title', with: ''
    expect {
      click_button '登録する'
    }.to change(Task, :count).by(0)
    expect(page).to have_content "Titleを入力してください"
  end

  scenario "Taskの新規作成時にdescriptionが''だとエラーが表示される" do
    user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
    visit tasks_path
    click_link '新規作成'
    fill_in 'Description', with: ''
    expect {
      click_button '登録する'
    }.to change(Task, :count).by(0)
    expect(page).to have_content "Descriptionを入力してください"
  end

  scenario "検索した文字列と一致するタイトルを返す" do
    user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
    Task.create(id: 1, title: "hello", description: "oo", user_id: 1)
    Task.create(id: 2, title: "hellorspec", description: "oo", user_id: 1)
    Task.create(id: 3, title: "helloruby", description: "oo", user_id: 1)
    Task.create(id: 4, title: "helloworld", description: "oo", user_id: 1)
    Task.create(id: 5, title: "hellorails", description: "oo", user_id: 1)
    visit tasks_path
    fill_in 'タイトルで検索', with: 'rspec'
    click_button '検索'
    expect(page).to have_content "hellorspec"
  end

  scenario "ステータスで検索する" do
    FactoryGirl.create(:task, title: "hello", status: 0)
    FactoryGirl.create(:task, title: "hellorspec", status: 1)
    FactoryGirl.create(:task, title: "helloruby", status: 2)
    FactoryGirl.create(:task, title: "helloworld", status: 1)
    FactoryGirl.create(:task, title: "hellorails", status: 0)
    visit tasks_path
    select '完了', from: 'ステータスを選択してください'
    click_button 'この条件で検索'
    expect(page).to have_content "ruby"
    expect(page).to_not have_content "rspec"
    expect(page).to_not have_content "world"
    expect(page).to_not have_content "rails"
  end

  scenario "優先順位で検索する" do
    User.create(id: 1, name: "hayashi", email: 'ttt@com')
    Task.create(id: 1, title: "hello", description: "oo", priority: 0, user_id: 1)
    Task.create(id: 2, title: "hellorspec", description: "oo", priority: 1, user_id: 1)
    Task.create(id: 3, title: "helloruby", description: "oo", priority: 2, user_id: 1)
    Task.create(id: 4, title: "helloworld", description: "oo", priority: 3, user_id: 1)
    Task.create(id: 5, title: "hellorails", description: "oo", priority: 0, user_id: 1)
    visit tasks_path
    select '緊急度３', from: '緊急度を選択してください'
    click_button 'この条件で検索'
    expect(page).to have_content "world"
    expect(page).to_not have_content "rspec"
    expect(page).to_not have_content "ruby"
    expect(page).to_not have_content "rails"
  end

end

