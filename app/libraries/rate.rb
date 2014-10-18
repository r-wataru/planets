class Rate
  class << self
    def batting_average(total)
      #打率	安打数÷打数　[小数点４位以下四捨五入]
      hits = (total.single_hits + total.double_hits + total.triple_hits + total.home_run)
      return hits.quo(total.at_bats).to_f.round(3)
    end

    def base_percentage(total)
      #出塁率	(四死球＋安打)÷(打数＋四死球＋犠飛)　[小数点４位以下四捨五入]
      hits = (total.single_hits + total.double_hits + total.triple_hits + total.home_run)
      four_and_dead = (total.base_on_balls + total.hit_by_pitches)
      return (hits + four_and_dead).quo(total.at_bats + four_and_dead + total.sacrifice_flies).to_f.round(3)
    end

    def number_of_batting(total)
      #打席数	打数＋四死球＋犠打＋犠飛＋妨害出塁
      four_and_dead = total.base_on_balls + total.hit_by_pitches
      sacrifice = sacrifice_bunts + sacrifice_flies
      return total.at_bats + four_and_dead + sacrifice
    end

    def total_bases(total)
      #『塁打数＝<単打>×1＋二塁打×2＋三塁打×3＋本塁打×4
      return (total.single_hits + total.double_hits * 2 + total.triple_hits * 3 + total.home_run * 4)
    end

    def slugging_percentage(total)
      #長打率	塁打÷打数　[小数点４位以下四捨五入]
      return total_bases(total).to_i.quo(total.at_bats).to_f.round(3)
    end

    def winning_rate(total)
      #勝率	勝数÷(勝数＋負数)
      unless total.winning + total.defeat == 0
        return total.winning.to_i.quo(total.winning + total.defeat).to_f.round(3)
      end
    end

    def struck_out_rate(total)
      # 奪三振数 奪三振×9÷投球回
      return (total.strikeouts * 9).quo(total.pitching_number).to_f.round(2)
    end

    def earned_run_average(total)
      #防御率	自責点×９÷投球回数　[小数点３位以下四捨五入]
      return (total.remorse_point * 9).quo(total.pitching_number).to_f.round(2)
    end

    def provisions_bat(season)
      #規定打席数	試合数×3.1　[小数点以下切り捨て]
      return (season.games.count * 3.1).to_i
    end
  end
end