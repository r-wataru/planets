class PitcherDisplay
  def initialize(season, sort_params)
    @season = season
    @games = @season.games
    @sort = sort_params
    @regulation = @games.count * 1
    users_id = @games.map{|g| g.pitchers.map{|r| r.user_id }}.flatten.uniq
    @users = User.where(id: users_id)
  end

  def display
    array = []
    @users.each do |user|
      hash = {}
      results = user.pitchers.where(game_id: @games.map(&:id))
      hash[:display_name] = user.display_name
      hash[:earned_run_average] = earned_run_average(results)
      hash[:set_games] = results.count
      hash[:winning] = winning(results)
      hash[:defeat] = defeat(results)
      hash[:hold_number] = hold_number(results)
      hash[:save_number] = save_number(results)
      hash[:winning_rate] = winning_rate(results)
      hash[:pitching_number] = pitching_number(results)
      hash[:hit] = hit(results)
      hash[:strikeouts] = strikeouts(results)
      hash[:struck_out_rate] = struck_out_rate(results)
      hash[:run] = run(results)
      hash[:remorse_point] = remorse_point(results)
      if hash[:pitching_number] > @regulation
        array << hash
      end
    end
    return sort(array)
  end

  def sort(array)
    if @sort.nil?
      array.sort {|a, b| b[:earned_run_average] <=> a[:earned_run_average] }
    else
      array.sort {|a, b| b[@sort.to_sym] <=> a[@sort.to_sym] }
    end
  end

  # 防御率
  def earned_run_average(results)
    total = {}
    total[:remorse_point] = remorse_point(results)
    total[:pitching_number] = pitching_number(results)
    Rate.earned_run_average(total)
  end

  # 奪三振率
  def struck_out_rate(results)
    total = {}
    total[:strikeouts] = strikeouts(results)
    total[:pitching_number] = pitching_number(results)
    Rate.struck_out_rate(total)
  end

  # 勝率
  def winning_rate(results)
    total = {}
    total[:winning] = winning(results)
    total[:defeat] = defeat(results)
    Rate.winning_rate(total)
  end

  # 勝
  def winning(results)
    results.map(&:winning).inject(:+)
  end

  # 敗
  def defeat(results)
    results.map(&:defeat).inject(:+)
  end

  # ホールド
  def hold_number(results)
    results.map(&:hold_number).inject(:+)
  end

  # セーブ
  def save_number(results)
    results.map(&:save_number).inject(:+)
  end

  # 投球回数
  def pitching_number(results)
    results.map(&:pitching_number).inject(:+)
  end

  # 被安打
  def hit(results)
    results.map(&:hit).inject(:+)
  end

  # 奪三振
  def strikeouts(results)
    results.map(&:strikeouts).inject(:+)
  end

  # 失点
  def run(results)
    results.map(&:run).inject(:+)
  end

  # 自責点
  def remorse_point(results)
    results.map(&:remorse_point).inject(:+)
  end
end