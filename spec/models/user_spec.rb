require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#create" do
    it "有効なファクトリを持つこと" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      user = FactoryGirl.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "emailがなければ無効な状態であること" do
      user = FactoryGirl.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "ユーザーの名前を文字列として返すこと" do
      user = FactoryGirl.build(:user, name: "kobayashi")
      expect(user.name).to eq "kobayashi"
    end

    it "重複したメールアドレスなら無効な状態であること" do
      FactoryGirl.create(:user, email: "aaron@example.com")
      user = FactoryGirl.build(:user, email: "aaron@example.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end

end
