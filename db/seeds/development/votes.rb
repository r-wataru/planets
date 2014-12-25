3.times do |n|
  Vote.create(title: "エントリー#{n}", description: "これは説明です。" * 3,
    user_id: User.first.id)
end

10.times do |n|
  Vote.create(
    title: "昔のエントリー#{n}", description: "これは説明です。" * 3,
    user_id: User.first.id, possible: false, result: true,
    period: "#{Date.today - n.month} ~ #{Date.today - n.month}",
    gold: n.odd? ? true : false)
end