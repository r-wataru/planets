10.times do |n|
  post = Post.create(
    user: User.first,
    title: "これはタイトルです#{n}",
    description: "これは説明です" * 10,
    publication: n.odd? ? true : false
  )
  User.all.each do |user|
    post.comments.create(
      user: user,
      comment: "これはコメントです。" * 2
    )
  end
end