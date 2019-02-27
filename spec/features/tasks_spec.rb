require 'rails_helper'

feature 'Task管理' do

  scenario"ユーザー登録ができること" do

  end

  scenario "期限が近い順で並び替えができていること" do
    task = FactoryGirl.create(:task, deadline: Date.current + 1)
    FactoryGirl.create(:task, deadline: Date.current + 2, user_id: task.user.id)
    FactoryGirl.create(:task, deadline: Date.current + 3, user_id: task.user.id)
    FactoryGirl.create(:task, deadline: Date.current + 4, user_id: task.user.id)
    visit '/login'
    fill_in 'Email', with: 'tester1@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    click_on '期限近い順で並べ替え'
    tasks = all('.task_item')
    expect(tasks[0]).to have_content "task1"
    expect(tasks[1]).to have_content "task2"
    expect(tasks[2]).to have_content "task3"
    expect(tasks[3]).to have_content "task4"
  end

  scenario "期限が遠い順で並び替えができていること" do
    task = FactoryGirl.create(:task, deadline: Date.current + 1)
    FactoryGirl.create(:task, deadline: Date.current + 2, user_id: task.user.id)
    FactoryGirl.create(:task, deadline: Date.current + 3, user_id: task.user.id)
    FactoryGirl.create(:task, deadline: Date.current + 4, user_id: task.user.id)
    visit '/login'
    fill_in 'Email', with: 'tester2@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    click_on '期限遠い順で並べ替え'
    tasks = all('.task_item')
    expect(tasks[0]).to have_content "task8"
    expect(tasks[1]).to have_content "task7"
    expect(tasks[2]).to have_content "task6"
    expect(tasks[3]).to have_content "task5"
  end

  scenario "作成日時の順番で並び替えができていること" do
    task = FactoryGirl.create(:task, created_at: Time.current - 1)
    FactoryGirl.create(:task, created_at: Time.current - 2, user_id: task.user.id)
    FactoryGirl.create(:task, created_at: Time.current - 3, user_id: task.user.id)
    FactoryGirl.create(:task, created_at: Time.current - 4, user_id: task.user.id)
    visit '/login'
    fill_in 'Email', with: 'tester3@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    tasks = all('.task_item')
    expect(tasks[0]).to have_content "9"
    expect(tasks[1]).to have_content "10"
    expect(tasks[2]).to have_content "11"
    expect(tasks[3]).to have_content "12"
  end

  scenario "Taskの新規作成時にtitleが''だとエラーが表示される" do
    FactoryGirl.create(:user)
    visit '/login'
    fill_in 'Email', with: 'tester4@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    click_link '新規作成'
    fill_in 'Title', with: ''
    fill_in 'Description', with: 'aaa'
    click_button '登録する'
    expect(page).to have_content "Titleを入力してください"
  end

  scenario "Taskの新規作成時にdescriptionが''だとエラーが表示される" do
    FactoryGirl.create(:user)
    visit '/login'
    fill_in 'Email', with: 'tester5@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    click_link '新規作成'
    fill_in 'Title', with: 'aaa'
    fill_in 'Description', with: ''
    click_button '登録する'
    expect(page).to have_content "Descriptionを入力してください"
  end

  scenario "検索した文字列と一致するタイトルを返す" do
    task = FactoryGirl.create(:task, title: "hello")
    FactoryGirl.create(:task, title: "hellorspec", user_id: task.user.id)
    FactoryGirl.create(:task, title: "helloruby", user_id: task.user.id)
    FactoryGirl.create(:task, title: "helloworld", user_id: task.user.id)
    FactoryGirl.create(:task, title: "hellorails", user_id: task.user.id)
    visit '/login'
    fill_in 'Email', with: 'tester6@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    fill_in 'タイトルで検索', with: 'rspec'
    click_button '検索'
    expect(page).to have_content "hellorspec"
  end

  scenario "ステータスで検索する" do
    task = FactoryGirl.create(:task, title: "hello", status: 0)
    FactoryGirl.create(:task, title: "hellorspec", status: 1, user_id: task.user.id)
    FactoryGirl.create(:task, title: "helloruby", status: 2, user_id: task.user.id)
    FactoryGirl.create(:task, title: "helloworld", status: 1, user_id: task.user.id)
    FactoryGirl.create(:task, title: "hellorails", status: 0, user_id: task.user.id)
    visit '/login'
    fill_in 'Email', with: 'tester7@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    select '完了', from: 'ステータスを選択してください'
    click_button 'この条件で検索'
    expect(page).to have_content "ruby"
    expect(page).to_not have_content "rspec"
    expect(page).to_not have_content "world"
    expect(page).to_not have_content "rails"
  end

  scenario "優先順位で検索する" do
    task = FactoryGirl.create(:task, title: "hello", priority: 0)
    FactoryGirl.create(:task, title: "hellorspec", priority: 1, user_id: task.user.id)
    FactoryGirl.create(:task, title: "helloruby", priority: 2, user_id: task.user.id)
    FactoryGirl.create(:task, title: "helloworld", priority: 3, user_id: task.user.id)
    FactoryGirl.create(:task, title: "hellorails", priority: 0, user_id: task.user.id)
    visit '/login'
    fill_in 'Email', with: 'tester8@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    select '緊急度３', from: '緊急度を選択してください'
    click_button 'この条件で検索'
    expect(page).to have_content "world"
    expect(page).to_not have_content "rspec"
    expect(page).to_not have_content "ruby"
    expect(page).to_not have_content "rails"
  end

end

