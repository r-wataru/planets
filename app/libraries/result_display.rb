class ResultDisplay
  def initialize(season, sort_params)
    @season = season
    @games = season.games
    users_id = @games.map{|g| g.results.map{|r| r.user_id }}.flatten.uniq
    @users = User.where(id: users_id)
    @sort = sort_params
    @regulation = @games.count * 1.4
  end

  def display
    array = []
    @users.each do |users|
      hash = {}
      results = users.results.where(game_id: @games.map(&:id))
      hash[:display_name] = users.display_name
      hash[:batting_average] = batting_average(results)
      hash[:game_count] = results.count
      hash[:plate_appearances] = plate(results)
      hash[:at_bats] = at_bats(results)
      hash[:total_hits] = total_hits(results)
      hash[:single_hits] = single_hits(results)
      hash[:double_hits] = double_hits(results)
      hash[:triple_hits] = triple_hits(results)
      hash[:home_run] = home_run(results)
      hash[:total_bases] = total_bases(results)
      hash[:runs_batted_in] = runs_batted_in(results)
      hash[:runs_scored] = runs_scored(results)
      hash[:strikeouts] = strikeouts(results)
      hash[:base_on_balls] = base_on_balls(results)
      hash[:hit_by_pitches] = hit_by_pitches(results)
      hash[:sacrifice_bunts] = sacrifice_bunts(results)
      hash[:sacrifice_flies] = sacrifice_flies(results)
      hash[:stolen_bases] = stolen_bases(results)
      hash[:base_percentage] = base_percentage(results)
      hash[:slugging_percentage] = slugging_percentage(results)
      if hash[:plate_appearances] > @regulation
        array << hash
      end
    end
    return sort(array)
  end

  def sort(array)
    if @sort.nil?
      array.sort {|a, b| b[:batting_average] <=> a[:batting_average] }
    else
      # 試合数
      array.sort {|a, b| b[@sort.to_sym] <=> a[@sort.to_sym] }
    end
  end

  # 打率
  def batting_average(results)
    Rate.batting_average(total_hash(results))
  end

  # 出塁率
  def base_percentage(results)
    total = total_hash(results)
    total[:base_on_balls] = base_on_balls(results)
    total[:hit_by_pitches] = hit_by_pitches(results)
    total[:sacrifice_flies] = sacrifice_flies(results)
    Rate.base_percentage(total)
  end

  # 長打率
  def slugging_percentage(results)
    Rate.slugging_percentage(total_hash(results))
  end

  # 試合数
  def plate(results)
    results.map(&:plate_appearances).inject(:+)
  end

  # 打数
  def at_bats(results)
    results.map(&:at_bats).inject(:+)
  end

  # ヒットの合計
  def total_hits(results)
    results.map(&:total_hits).inject(:+)
  end

  # 安打
  def single_hits(results)
    results.map(&:single_hits).inject(:+)
  end

  # 二塁打
  def double_hits(results)
    results.map(&:double_hits).inject(:+)
  end

  # 三塁打
  def triple_hits(results)
    results.map(&:triple_hits).inject(:+)
  end

  # 本塁打
  def home_run(results)
    results.map(&:home_run).inject(:+)
  end

  # 塁打数
  def total_bases(results)
    results.map(&:total_bases).inject(:+)
  end

  # 打点
  def runs_batted_in(results)
    results.map(&:runs_batted_in).inject(:+)
  end

  # 得点
  def runs_scored(results)
    results.map(&:runs_scored).inject(:+)
  end

  # 三振
  def strikeouts(results)
    results.map(&:strikeouts).inject(:+)
  end

  # 四球
  def base_on_balls(results)
    results.map(&:base_on_balls).inject(:+)
  end

  # 死球
  def hit_by_pitches(results)
    results.map(&:hit_by_pitches).inject(:+)
  end

  # 犠打
  def sacrifice_bunts(results)
    results.map(&:sacrifice_bunts).inject(:+)
  end

  # 犠飛
  def sacrifice_flies(results)
    results.map(&:sacrifice_flies).inject(:+)
  end

  # 盗塁
  def stolen_bases(results)
    results.map(&:stolen_bases).inject(:+)
  end

  # ヒットと打数
  def total_hash(results)
    total = {}
    total[:single_hits] = single_hits(results)
    total[:double_hits] = double_hits(results)
    total[:triple_hits] = triple_hits(results)
    total[:home_run] = home_run(results)
    total[:at_bats] = at_bats(results)
    return total
  end
end