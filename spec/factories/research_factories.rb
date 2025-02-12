FactoryBot.define do
  factory :concept, class: Hash do
    skip_create
    id { Faker::Alphanumeric.alpha(number: 10) }
    name { Faker::Science.element }
    description { Faker::Lorem.sentence }

    initialize_with { attributes }
  end

  factory :relationship, class: Hash do
    skip_create
    source { Faker::Science.element }
    target { Faker::Science.element }
    type { %w[related depends_on].sample }

    initialize_with { attributes }
  end

  factory :iteration, class: Hash do
    skip_create
    number { Faker::Number.between(from: 1, to: 10) }
    questions { [Faker::Lorem.question, Faker::Lorem.question] }
    responses { [Faker::Lorem.sentence, Faker::Lorem.sentence] }

    initialize_with { attributes }
  end
end