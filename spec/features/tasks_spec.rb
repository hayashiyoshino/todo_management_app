require 'rails_helper'

feature 'Task管理' do

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
