10.times do |n|
  Plan.create!(
    starts_on: Date.today + (n * 3).days
  )
end

Plan.all.each_with_index do |plan, i|
  (i + 1).times do
    plan.plan_details.create(
      name: "第#{i}試合",
      description: "これは説明です。" * 2,
      starts_on: Time.now - (i * 2).hour,
      ends_on: Time.now - i.hour
    )
  end
end