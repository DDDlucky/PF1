require 'rails_helper'

RSpec.describe 'Bookモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { book.valid? }

    let(:user) { create(:user) }
    let!(:book) { build(:book, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        book.title = ''
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        book.body = ''
        is_expected.to eq false
      end
      it '500文字以下であること: 500文字は〇' do
        book.body = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
      end
      it '500文字以下であること: 501文字は×' do
        book.body = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Book.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
