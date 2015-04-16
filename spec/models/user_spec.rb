require 'spec_helper'


describe User do
  before :each do
    allow(GitlabToken).to receive(:token_by_dn).and_return('gitlabdogetoken')
  end
  
  it { should have_many(:repos).through(:memberships) }
  it { should validate_presence_of :gitlab_username }

  describe '#create' do
    it 'generates a remember_token' do
      user = build(:user)
      allow(SecureRandom).to receive(:hex) { "remembertoken" }

      user.save

      expect(SecureRandom).to have_received(:hex).with(20)
      expect(user.remember_token).to eq 'remembertoken'
    end
  end

  describe '#to_s' do
    it 'returns GitLab username' do
      user = build(:user)

      user_string = user.to_s

      expect(user_string).to eq user.gitlab_username
    end
  end

  describe '#has_repos_with_missing_information?' do
    context 'with repo without privacy info' do
      it 'return true' do
        user = create(:user)
        repo = create(:repo, private: nil)
        user.repos << repo

        expect(user).to have_repos_with_missing_information
      end
    end

    context 'with repo without organization and privacy info' do
      it 'returns true' do
        user = create(:user)
        repo = create(:repo, private: nil)
        user.repos << repo

        expect(user).to have_repos_with_missing_information
      end
    end

    context 'with repo with organization and privacy info' do
      it 'returns false' do
        user = create(:user)
        repo = create(:repo, private: true)
        user.repos << repo

        expect(user).not_to have_repos_with_missing_information
      end
    end
  end
end
