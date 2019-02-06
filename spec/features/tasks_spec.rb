require 'rails_helper'



feature 'Task管理' do
  scenario "作成日時の順番で並び替えができていること" do
    Task.create(id: 1, title: 'hi', description: 'hi', deadline: Time.current + 15.day)
    Task.create(id: 2, title: 'hi', description: 'hihi2', created_at: Time.current + 1.days, deadline: Time.current + 12.days)
    Task.create(id: 3, title: 'hiii', description: 'hihi3', created_at: Time.current + 2.days, deadline: Time.current + 16.days)
    Task.create(id: 4, title: 'hiiiii', description: 'hihi4', created_at: Time.current + 3.days, deadline: Time.current + 110.days)
    visit tasks_path
    task = all('.task_list')
    task_0 = task[0]
    expect(task_0).to have_content "4"
    save_and_open_page
  end

  scenario "期限が近い順で並び替えができていること" do
    Task.create(id: 5, title: '期限1', description: '期限１', deadline: Time.current + 5.days)
    Task.create(id: 6, title: '期限2', description: '期限２', deadline: Time.current + 2.days)
    Task.create(id: 7, title: '期限3', description: '期限３', deadline: Time.current + 6.days)
    Task.create(id: 8, title: '期限4', description: '期限４', deadline: Time.current + 10.days)
    visit tasks_path
    click_link '期限近い順で並べ替え'
    task = all('.tasl_list')
    task_0 = task[0]
    task_1 = task[1]
    tasl_2 = task[2]
    task_3 = task[3]
    expect(task_0).to have_content "2"
    expect(task_1).to have_content "5"
    expect(task_2).to have_content "3"
    expect(task_3).to have_content "4"
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
