5.times do |n|
  post = Post.create(
    user: User.first,
    title: "これはタイトルです#{n}",
    description: "これは説明です" * 10
  )
  User.all.each do |user|
    post.comments.create(
      user: user,
      comment: "これはコメントです。" * 2
    )
  end
end