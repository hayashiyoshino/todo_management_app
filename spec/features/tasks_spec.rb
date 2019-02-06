require 'rails_helper'

feature 'Task管理' do
  scenario "作成日時の順番で並び替えができていること" do
    Task.create(id: 1, title: 'hi', description: 'hi')
    Task.create(id: 2, title: 'hi', description: 'hihi2', created_at: Time.current + 1.days)
    Task.create(id: 3, title: 'hiii', description: 'hihi3', created_at: Time.current + 2.days)
    Task.create(id: 4, title: 'hiiiii', description: 'hihi4', created_at: Time.current + 3.days)
    visit tasks_path
    task = all('.task_list')
    task_0 = task[0]
    expect(task_0).to have_content "4"
    save_and_open_page
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


end
