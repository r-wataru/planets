balls = %w(ストレート カーブ スライダー シュート フォーク スプリット シンカー ツーシーム カットボール チェンジアップ ナックル パーム)

balls.each do |ball|
  BreakingBall.create!(
    name: ball
  )
end