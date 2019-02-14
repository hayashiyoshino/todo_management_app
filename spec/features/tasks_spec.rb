require 'rails_helper'

feature 'Task管理' do

  scenario "期限が近い順で並び替えができていること" do
    Task.create(id: 1, title: 'タスク1', description: '期限１', deadline: Time.current + 5.days)
    Task.create(id: 2, title: 'タスク2', description: '期限２', deadline: Time.current + 2.days)
    Task.create(id: 3, title: 'タスク3', description: '期限３', deadline: Time.current + 6.days)
    Task.create(id: 4, title: 'タスク4', description: '期限４', deadline: Time.current + 10.days)
    visit tasks_path
    click_on '期限近い順で並べ替え'
    task = all('.task_item')
    expect(task[0]).to have_content "タスク2"
    expect(task[1]).to have_content "タスク1"
    expect(task[2]).to have_content "タスク3"
    expect(task[3]).to have_content "タスク4"
  end

  scenario "期限が遠い順で並び替えができていること" do
    Task.create(id: 1, title: 'タスク1', description: '期限１', deadline: Time.current + 5.days)
    Task.create(id: 2, title: 'タスク2', description: '期限２', deadline: Time.current + 2.days)
    Task.create(id: 3, title: 'タスク3', description: '期限３', deadline: Time.current + 6.days)
    Task.create(id: 4, title: 'タスク4', description: '期限４', deadline: Time.current + 10.days)
    visit tasks_path
    click_on '期限遠い順で並べ替え'
    task = all('.task_item')
    expect(task[0]).to have_content "タスク4"
    expect(task[1]).to have_content "タスク3"
    expect(task[2]).to have_content "タスク1"
    expect(task[3]).to have_content "タスク2"
  end

  scenario "作成日時の順番で並び替えができていること" do
    Task.create(id: 1, title: 'hi', description: 'hi', deadline: Time.current + 15.day)
    Task.create(id: 2, title: 'hi', description: 'hihi2', created_at: Time.current + 1.days, deadline: Time.current + 12.days)
    Task.create(id: 3, title: 'hiii', description: 'hihi3', created_at: Time.current + 2.days, deadline: Time.current + 16.days)
    Task.create(id: 4, title: 'hiiiii', description: 'hihi4', created_at: Time.current + 3.days, deadline: Time.current + 110.days)
    visit tasks_path
    task = all('.task_item')
    expect(task[0]).to have_content "4"
  end

  scenario "Taskを作成する" do
    visit tasks_path
    click_link '新規作成'
    fill_in 'Title', with: 'hello'
    fill_in 'Description', with: 'helloworld'
    click_button '登録する'
    expect(page).to have_content 'TODOを新規作成しました！'
  end
  scenario "Taskの新規作成時にtitleが''だとエラーが表示される" do
    visit tasks_path
    click_link '新規作成'
    fill_in 'Title', with: ''
    expect {
      click_button '登録する'
    }.to change(Task, :count).by(0)
    expect(page).to have_content "Titleを入力してください"
  end

  scenario "Taskの新規作成時にdescriptionが''だとエラーが表示される" do
    visit tasks_path
    click_link '新規作成'
    fill_in 'Description', with: ''
    expect {
      click_button '登録する'
    }.to change(Task, :count).by(0)
    expect(page).to have_content "Descriptionを入力してください"
  end

  scenario "検索した文字列と一致するタイトルを返す" do
    task1 = Task.create(id: 1, title: "hello", description: "oo")
    task2 = Task.create(id: 2, title: "hellorspec", description: "oo")
    task3 = Task.create(id: 3, title: "helloruby", description: "oo")
    task4 = Task.create(id: 4, title: "helloworld", description: "oo")
    task5 = Task.create(id: 5, title: "hellorails", description: "oo")
    visit tasks_path
    fill_in 'タイトルで検索', with: 'rspec'
    click_button '検索'
    expect(page).to have_content "hellorspec"
  end

end
