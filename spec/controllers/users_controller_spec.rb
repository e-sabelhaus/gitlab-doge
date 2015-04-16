require 'spec_helper'

describe UsersController do
  describe '#show' do
    it 'returns current user in json' do
      allow(GitlabToken).to receive(:token_by_dn).and_return('gitlabdogetoken')
      user = create(:user)
      stub_sign_in(user)

      get :show, format: :json

      expect(response.body).to eq user_json(user)
    end
  end

  def user_json(user)
    user.attributes.slice('id', 'gitlab_username', 'refreshing_repos').to_json
  end
end
