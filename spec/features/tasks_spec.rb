require 'rails_helper'

feature 'Task管理' do

  scenario"ユーザー登録ができること" do

  end

  scenario "期限が近い順で並び替えができていること" do
    4.times { FactoryGirl.create(:task) }
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
    4.times { FactoryGirl.create(:task) }
    visit '/login'
    fill_in 'Email', with: 'tester5@example.com'
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
    4.times { FactoryGirl.create(:task) }
    visit '/login'
    fill_in 'Email', with: 'tester9@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    tasks = all('.task_item')
    expect(tasks[0]).to have_content "9"
  end

  #ログイン機能作ってから
  # scenario "Taskを作成する" do
  #   visit tasks_path
  #   click_link '新規作成'
  #   fill_in 'Title', with: 'hello'
  #   fill_in 'Description', with: 'helloworld'
  #   click_button '登録する'
  #   expect(page).to have_content 'TODOを新規作成しました！'
  # end

  scenario "Taskの新規作成時にtitleが''だとエラーが表示される" do
    FactoryGirl.create(:user)
    visit '/login'
    fill_in 'Email', with: 'tester13@example.com'
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
    fill_in 'Email', with: 'tester14@example.com'
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
    FactoryGirl.create(:task, title: "hello")
    FactoryGirl.create(:task, title: "hellorspec")
    FactoryGirl.create(:task, title: "helloruby")
    FactoryGirl.create(:task, title: "helloworld")
    FactoryGirl.create(:task, title: "hellorails")
    visit '/login'
    fill_in 'Email', with: 'tester15@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
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
    visit '/login'
    fill_in 'Email', with: 'tester20@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    select '完了'
    click_button 'ステータスで検索'
    expect(page).to have_content "ruby"
    expect(page).to_not have_content "rspec"
    expect(page).to_not have_content "world"
    expect(page).to_not have_content "rails"
  end

  scenario "優先順位で検索する" do
    FactoryGirl.create(:task, title: "hello", priority: 0)
    FactoryGirl.create(:task, title: "hellorspec", priority: 1)
    FactoryGirl.create(:task, title: "helloruby", priority: 2)
    FactoryGirl.create(:task, title: "helloworld", priority: 3)
    FactoryGirl.create(:task, title: "hellorails", priority: 0)
    visit '/login'
    fill_in 'Email', with: 'tester25@example.com'
    fill_in 'Password digest', with: '11111111'
    click_on 'ログイン'
    click_on 'TODOリスト'
    select '緊急度３'
    click_button '緊急度で検索'
    expect(page).to have_content "world"
    expect(page).to_not have_content "rspec"
    expect(page).to_not have_content "ruby"
    expect(page).to_not have_content "rails"
  end

end