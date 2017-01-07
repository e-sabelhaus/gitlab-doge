FactoryGirl.define do
  factory :build do
    repo

    trait :failed_build do
      violations ['WhitespaceRule on line 34 of app/models/user.rb']
    end
  end

  factory :repo do
    trait(:active) { active true }
    trait(:inactive) { active false }

    sequence(:full_gitlab_name) { |n| "user/repo#{n}" }
    sequence(:gitlab_id) { |n| n }
    private false

    after(:create) do |repo|
      if repo.users.empty?
        repo.users << create(:user)
      end
    end
  end

  factory :user do
    dn "getalonglittledogegetalong"
    sequence(:gitlab_username) { |n| "gitlab#{n}" }

    trait(:refreshing) { refreshing_repos true }
    trait(:not_refreshing) { refreshing_repos false }

    ignore do
      repos []
    end

    after(:build) do |user, evaluator|
      if evaluator.repos.any?
        user.repos += evaluator.repos
      end
    end
  end

  factory :membership do
    user
    repo
  end
end
