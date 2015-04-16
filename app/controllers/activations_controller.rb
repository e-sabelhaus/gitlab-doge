class ActivationsController < ApplicationController
  class FailedToActivate < StandardError; end

  respond_to :json

  def create
    if activator.activate
      render json: repo, status: :created
    else
      head 502
    end
  end

  private

  def activator
    RepoActivator.new(repo: repo, gitlab_token: gitlab_token)
  end

  def repo
    @repo ||= current_user.repos.find(params[:repo_id])
  end

  def gitlab_token
    current_user.gitlab_token_string
  end
end
