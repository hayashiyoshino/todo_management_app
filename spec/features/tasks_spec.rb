require 'rails_helper'

feature 'Task管理' do

  scenario "期限が近い順で並び替えができていること" do
    user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
    Task.create(id: 1, title: '期限1', description: '期限１', deadline: Time.current + 5.days, user_id: 1)
    Task.create(id: 2, title: '期限2', description: '期限２', deadline: Time.current + 2.days, user_id: 1)
    Task.create(id: 3, title: '期限3', description: '期限３', deadline: Time.current + 6.days, user_id: 1)
    Task.create(id: 4, title: '期限4', description: '期限４', deadline: Time.current + 10.days, user_id: 1)
    visit tasks_path
    click_on '期限近い順で並べ替え'
    tasks = all('.task_item')
    expect(tasks[0]).to have_content "タスク2"
    expect(tasks[1]).to have_content "タスク1"
    expect(tasks[2]).to have_content "タスク3"
    expect(tasks[3]).to have_content "タスク4"
  end

  scenario "期限が遠い順で並び替えができていること" do
    Task.create(id: 1, title: 'タスク1', description: '期限１', deadline: Time.current + 5.days)
    Task.create(id: 2, title: 'タスク2', description: '期限２', deadline: Time.current + 2.days)
    Task.create(id: 3, title: 'タスク3', description: '期限３', deadline: Time.current + 6.days)
    Task.create(id: 4, title: 'タスク4', description: '期限４', deadline: Time.current + 10.days)
    visit tasks_path
    click_on '期限遠い順で並べ替え'
    tasks = all('.task_item')
    expect(tasks[0]).to have_content "タスク4"
    expect(tasks[1]).to have_content "タスク3"
    expect(tasks[2]).to have_content "タスク1"
    expect(tasks[3]).to have_content "タスク2"
  end

  scenario "作成日時の順番で並び替えができていること" do
    user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
    Task.create(id: 1, title: 'hi', description: 'hi', deadline: Time.current + 15.day, user_id: 1)
    Task.create(id: 2, title: 'hi', description: 'hihi2', created_at: Time.current + 1.days, deadline: Time.current + 12.days, user_id: 1)
    Task.create(id: 3, title: 'hiii', description: 'hihi3', created_at: Time.current + 2.days, deadline: Time.current + 16.days, user_id: 1)
    Task.create(id: 4, title: 'hiiiii', description: 'hihi4', created_at: Time.current + 3.days, deadline: Time.current + 110.days, user_id: 1)
    visit tasks_path
    tasks = all('.task_item')
    expect(tasks[0]).to have_content "4"
  end

  scenario "Taskを作成する" do
    user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
    visit tasks_path
    click_link '新規作成'
    fill_in 'Title', with: 'hello'
    fill_in 'Description', with: 'helloworld'
    click_button '登録する'
    expect(page).to have_content 'TODOを新規作成しました！'
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
    Task.create(id: 1, title: "hello", description: "oo", status: 0)
    Task.create(id: 2, title: "hellorspec", description: "oo", status: 1)
    Task.create(id: 3, title: "helloruby", description: "oo", status: 2)
    Task.create(id: 4, title: "helloworld", description: "oo", status: 1)
    Task.create(id: 5, title: "hellorails", description: "oo", status: 0)
    visit tasks_path
    select '完了'
    click_button 'ステータスで検索'
    expect(page).to have_content "ruby"
    expect(page).to_not have_content "rspec"
    expect(page).to_not have_content "wordl"
    expect(page).to_not have_content "rails"
  end

  scenario "優先順位で検索する" do
    user = User.create(id: 1, name: "hayashi", email: 'ttt@com')
    Task.create(id: 1, title: "hello", description: "oo", priority: 0, user_id: 1)
    Task.create(id: 2, title: "hellorspec", description: "oo", priority: 1, user_id: 1)
    Task.create(id: 3, title: "helloruby", description: "oo", priority: 2, user_id: 1)
    Task.create(id: 4, title: "helloworld", description: "oo", priority: 3, user_id: 1)
    Task.create(id: 5, title: "hellorails", description: "oo", priority: 0, user_id: 1)
    visit tasks_path
    select '緊急度３'
    click_button '緊急度で検索'
    expect(page).to have_content "world"
    expect(page).to_not have_content "rspec"
    expect(page).to_not have_content "ruby"
    expect(page).to_not have_content "rails"
  end

end