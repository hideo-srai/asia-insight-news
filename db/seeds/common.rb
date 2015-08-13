require 'faker'

Author.destroy_all
Post.destroy_all
CentralBank.destroy_all
Link.destroy_all
Event.destroy_all
BlogPost.destroy_all

3.times do
  BlogPost.create(
      headline: fake_words(12).capitalize,
      readout: fake_sentences(2),
      content: fake_sentences(8),
      published_at: rand(20).days.ago
  )
end

authors = 12.times.map do
  Author.create(name: Faker::Name.name, bio: fake_sentences(12))
end

142.times do
  Post.create(
      post_sections: random_models(PostSection, rand(3) + 1),
      authors: [authors.sample, authors.sample],
      authors_pick: random_boolean(0.3),
      featured_level: [nil, 1, 2, 3].sample,
      is_breaking_news: random_boolean(0.2),

      countries: random_models(Country, 3),
      cover: (fake_image if random_boolean(0.1)),

      headline: fake_words(12).capitalize,
      byline: fake_sentences(4).capitalize,
      content: fake_paragraphs(20),
      in_digest: random_boolean,
      published: random_boolean(0.8),
      published_at: rand(20).days.ago,

      in_ticker: random_boolean(0.3)
  )
end

12.times do
  CentralBank.create(
      bank_name: "#{fake_words(2).capitalize} Bank",
      bank_link: Faker::Internet.url,
      policy_target: fake_words(5),
      current_settings: "#{rand(10)}%",
      change: "+#{rand(10)}bps",
      next_policy_announcement: "#{rand(30)}-Dec-14",
      change_expected: ['Easing Bias', 'Neutral'].sample,
      report_name: fake_words(4),
      report_link: Faker::Internet.url,
      in_ticker: random_boolean(0.3),
      changed_at: rand(100).days.ago
  )
end

10.times do
  Link.create(
      title: fake_words(3).capitalize,
      description: fake_words(10).capitalize,
      published_at: Time.zone.now,
      url: Faker::Internet.url,
      in_ticker: random_boolean(0.3)
  )
end

10.times do
  Event.create(title: fake_words(4).capitalize,
               data_for: fake_words(6),
               country: random_model(Country),
               date: Faker::Date.forward(2.weeks),
               time_local: Faker::Time.forward(2.weeks),
               time_gmt: Faker::Time.forward(2.weeks),
               in_ticker: random_boolean(0.3)
  )
end