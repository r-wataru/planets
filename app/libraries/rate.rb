class Rate
  class << self
    def hits(total)
      if total.kind_of?(Hash)
        (total[:single_hits] + total[:double_hits] + total[:triple_hits] + total[:home_run])
      else
        (total.single_hits + total.double_hits + total.triple_hits + total.home_run)
      end
    end

    def at_bats(total)
      if total.kind_of?(Hash)
        total[:at_bats]
      else
        total.at_bats
      end
    end

    #打率	安打数÷打数　[小数点４位以下四捨五入]
    def batting_average(total)
      hits = hits(total)
      if total.kind_of?(Hash)
        at_bats = total[:at_bats]
      else
        at_bats = total.at_bats
      end
      begin
        return hits.quo(at_bats).to_f.round(3)
      rescue
        return hits.to_f.round(3)
      end
    end

    #出塁率	(四死球＋安打)÷(打数＋四死球＋犠飛)　[小数点４位以下四捨五入]
    def base_percentage(total)
      hits = hits(total)
      if total.kind_of?(Hash)
        four_and_dead = (total[:base_on_balls] + total[:hit_by_pitches])
        sacrifice_flies = total[:sacrifice_flies]
      else
        four_and_dead = (total.base_on_balls + total.hit_by_pitches)
        sacrifice_flies = total.sacrifice_flies
      end
      begin
        return (hits + four_and_dead).quo(at_bats(total) + four_and_dead + sacrifice_flies).to_f.round(3)
      rescue
        return (hits + four_and_dead).to_f.round(3)
      end
    end

    #『塁打数＝<単打>×1＋二塁打×2＋三塁打×3＋本塁打×4
    def total_bases(total)
      if total.kind_of?(Hash)
        return (total[:single_hits] + total[:double_hits] * 2 + total[:triple_hits] * 3 + total[:home_run] * 4)
      else
        return (total.single_hits + total.double_hits * 2 + total.triple_hits * 3 + total.home_run * 4)
      end
    end

    #長打率	塁打÷打数　[小数点４位以下四捨五入]
    def slugging_percentage(total)
      begin
        return total_bases(total).to_i.quo(at_bats(total)).to_f.round(3)
      rescue
        return total_bases(total).to_f.round(3)
      end
    end

    #勝率	勝数÷(勝数＋負数)
    def winning_rate(total)
      if total[:winning] + total[:defeat] == 0
        return 0
      else
        begin
          return total[:winning].to_i.quo(total[:winning] + total[:defeat]).to_f.round(3)
        rescue
          return 0
        end
      end
    end

    #防御率	自責点×９÷投球回数　[小数点３位以下四捨五入]
    def earned_run_average(total)
      if total.kind_of?(Hash)
        remorse_point = total[:remorse_point]
        pitching_number = total[:pitching_number]
      else
        remorse_point = total.remorse_point
        pitching_number = total.pitching_number
      end
      begin
        return (remorse_point * 9).quo(pitching_number).to_f.round(3)
      rescue
        return (remorse_point * 9).to_f.round(3)
      end
    end

    # 奪三振数 奪三振×9÷投球回
    def struck_out_rate(total)
      begin
        (total[:strikeouts] * 9).quo(total[:pitching_number]).to_f.round(2)
      rescue
        return (total[:strikeouts] * 9).to_f.round(2)
      end
    end

    def number_of_batting(total)
      #打席数	打数＋四死球＋犠打＋犠飛＋妨害出塁
      four_and_dead = total.base_on_balls + total.hit_by_pitches
      sacrifice = sacrifice_bunts + sacrifice_flies
      return total.at_bats + four_and_dead + sacrifice
    end

    def provisions_bat(season)
      #規定打席数	試合数×3.1　[小数点以下切り捨て]
      return (season.games.count * 3.1).to_i
    end
  end
end