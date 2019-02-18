require 'rails_helper'

feature 'User' do

  scenario "ユーザーが登録できること" do
    visit '/users/new'
    fill_in 'Name', with: 'test'
    fill_in 'Email', with: 'tester1@example.com'
    fill_in 'Password', with: '11111111'
    fill_in 'Password confirmation', with: '11111111'
    click_button '新規登録'
    expect(page).to have_content "新規登録しました！"
  end

  scenario 'ログインできること' do
    FactoryGirl.create(:user, email: 'test1@test.com')
    visit '/login'
    fill_in 'Email', with: 'test1@test.com'
    fill_in 'Password digest', with: '11111111'
    click_button 'ログイン'
    expect(page).to have_content "ログインしました！"
  end

  end