class AnalysisController < ApplicationController
  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?

    year = params[:year].to_i
    if year < 2000 || 3000 < year
      year = Date.today.year
    end

    @sum_category, @sum_category_yearly = sum_category(year: year, source: :all)
    @sum_category_central, @sum_category_yearly_central = sum_category(year: year, source: :central)
    @sum_category_hide, @sum_category_yearly_hide = sum_category(year: year, source: :hide)

    @sum_yearly = @sum_category_yearly.inject(0) { |result, h| result + h[:data]['支出'].to_i }
    @sum_yearly_central = @sum_category_yearly_central.inject(0) { |result, h| result + h[:data]['支出'].to_i }
    @sum_yearly_hide = @sum_category_yearly_hide.inject(0) { |result, h| result + h[:data]['支出'].to_i }

    @sum_energy = sum_energy(year: year)
    @sum_yearly_energy = @sum_energy.inject({}) { |result, h| result.merge(h[:data]) { |_, old, new| old + new } }.values.inject(:+)


    @sum_entertainment, @sum_entertainment_yearly = sum_entertainment(year: year)

    @sum_group = sum_group(year: year)
  end

  private

  def sum_category(year: 2020, source: :all)
    sum_category = []
    sum_category_yearly = []
    meal = {}
    commodities = {}
    traffic = {}
    energy = {}
    housing = {}
    social = {}
    entertainment = {}
    culture = {}
    healthcare = {}
    clothing = {}
    car = {}
    tax = {}
    others = {}
    sport = {}
    information = {}
    income = {}
    bike = {}
    pet = {}
    investing = {}
    gamble = {}
    (1..12).each do |m|
      meal[m.to_s]          = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769342).total
      commodities[m.to_s]   = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769343).total
      traffic[m.to_s]       = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769344).total
      energy[m.to_s]        = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769346).total
      housing[m.to_s]       = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769347).total
      social[m.to_s]        = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769348).total
      entertainment[m.to_s] = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769349).total
      culture[m.to_s]       = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769350).total
      healthcare[m.to_s]    = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769351).total
      clothing[m.to_s]      = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769352).total
      car[m.to_s]           = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769353).total
      tax[m.to_s]           = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769354).total
      others[m.to_s]        = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(  769356).total
      sport[m.to_s]         = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(12997396).total
      information[m.to_s]   = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(13014108).total
      income[m.to_s]        =  @user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(13123188).total
      bike[m.to_s]          = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(24927167).total
      pet[m.to_s]           = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(24927661).total
      investing[m.to_s]     = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(25117604).total
      gamble[m.to_s]        = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(25118133).total
    end
    sum_category << { name: '食費',         data: meal          }
    sum_category << { name: '日用雑貨',     data: commodities   }
    sum_category << { name: '交通費',       data: traffic       }
    sum_category << { name: '水道・光熱',   data: energy        }
    sum_category << { name: '住宅',         data: housing       }
    sum_category << { name: '交際費',       data: social        }
    sum_category << { name: 'エンタメ',     data: entertainment }
    sum_category << { name: '教育・教養',   data: culture       }
    sum_category << { name: '健康・医療',   data: healthcare    }
    sum_category << { name: '衣服・美容',   data: clothing      }
    sum_category << { name: 'クルマ',       data: car           }
    sum_category << { name: '税金',         data: tax           }
    sum_category << { name: 'その他',       data: others        }
    sum_category << { name: '運動',         data: sport         }
    sum_category << { name: 'IT',           data: information   }
    sum_category << { name: 'バイク',       data: bike          }
    sum_category << { name: 'ペット',       data: pet           }
    sum_category << { name: '投資・財テク', data: investing     }
    sum_category << { name: 'ギャンブル',   data: gamble        }

    sum_category_yearly << { name: '食費',         data: { '支出' => meal.values.inject(:+) } }
    sum_category_yearly << { name: '日用雑貨',     data: { '支出' => commodities.values.inject(:+) } }
    sum_category_yearly << { name: '交通費',       data: { '支出' => traffic.values.inject(:+) } }
    sum_category_yearly << { name: '水道・光熱',   data: { '支出' => energy.values.inject(:+) } }
    sum_category_yearly << { name: '住宅',         data: { '支出' => housing.values.inject(:+) } }
    sum_category_yearly << { name: '交際費',       data: { '支出' => social.values.inject(:+) } }
    sum_category_yearly << { name: 'エンタメ',     data: { '支出' => entertainment.values.inject(:+) } }
    sum_category_yearly << { name: '教育・教養',   data: { '支出' => culture.values.inject(:+) } }
    sum_category_yearly << { name: '健康・医療',   data: { '支出' => healthcare.values.inject(:+) } }
    sum_category_yearly << { name: '衣服・美容',   data: { '支出' => clothing.values.inject(:+) } }
    sum_category_yearly << { name: 'クルマ',       data: { '支出' => car.values.inject(:+) } }
    sum_category_yearly << { name: '税金',         data: { '支出' => tax.values.inject(:+) } }
    sum_category_yearly << { name: 'その他',       data: { '支出' => others.values.inject(:+) } }
    sum_category_yearly << { name: '運動',         data: { '支出' => sport.values.inject(:+) } }
    sum_category_yearly << { name: 'IT',           data: { '支出' => information.values.inject(:+) } }
    sum_category_yearly << { name: 'バイク',       data: { '支出' => bike.values.inject(:+) } }
    sum_category_yearly << { name: 'ペット',       data: { '支出' => pet.values.inject(:+) } }
    sum_category_yearly << { name: '投資・財テク', data: { '支出' => investing.values.inject(:+) } }
    sum_category_yearly << { name: 'ギャンブル',   data: { '支出' => gamble.values.inject(:+) } }
    sum_category_yearly << { name: '収入',         data: { '収入' => income.values.inject(:+) } }

    [sum_category, sum_category_yearly]
  end

  def sum_energy(year: 2020)
    sum_energy = []
    water = {}
    gas = {}
    electricity = {}
    (1..12).each do |m|
      water[m.to_s]       = -@user.transactions.valid.not_nae.month(year, m).category_id(3590254).total
      electricity[m.to_s] = -@user.transactions.valid.not_nae.month(year, m).category_id(3590255).total
      gas[m.to_s]         = -@user.transactions.valid.not_nae.month(year, m).category_id(3590256).total
    end
    sum_energy << { name: '電気', data: electricity }
    sum_energy << { name: '水道', data: water       }
    sum_energy << { name: 'ガス', data: gas         }
  end

  def sum_entertainment(year: 2020)
    sum_entertainment = []
    sum_entertainment_yearly = []
    leisure = {}
    event   = {}
    movie   = {}
    music   = {}
    comic   = {}
    book    = {}
    game    = {}
    hotel   = {}
    spring  = {}
    karaoke = {}
    temple  = {}
    netcafe = {}
    toy     = {}
    camera  = {}
    travel  = {}
    night   = {}
    darts   = {}
    (1..12).each do |m|
      leisure[m.to_s] = -@user.transactions.valid.not_nae.month(year, m).category_id( 3590269).total
      event[m.to_s]   = -@user.transactions.valid.not_nae.month(year, m).category_id( 3590270).total
      movie[m.to_s]   = -@user.transactions.valid.not_nae.month(year, m).category_id( 3590271).total
      music[m.to_s]   = -@user.transactions.valid.not_nae.month(year, m).category_id( 3590272).total
      comic[m.to_s]   = -@user.transactions.valid.not_nae.month(year, m).category_id( 3590273).total
      book[m.to_s]    = -@user.transactions.valid.not_nae.month(year, m).category_id( 3590274).total
      game[m.to_s]    = -@user.transactions.valid.not_nae.month(year, m).category_id( 3590275).total
      hotel[m.to_s]   = -@user.transactions.valid.not_nae.month(year, m).category_id( 4884823).total
      spring[m.to_s]  = -@user.transactions.valid.not_nae.month(year, m).category_id( 5342459).total
      karaoke[m.to_s] = -@user.transactions.valid.not_nae.month(year, m).category_id( 5759860).total
      temple[m.to_s]  = -@user.transactions.valid.not_nae.month(year, m).category_id( 9620445).total
      netcafe[m.to_s] = -@user.transactions.valid.not_nae.month(year, m).category_id( 9620454).total
      toy[m.to_s]     = -@user.transactions.valid.not_nae.month(year, m).category_id( 9620455).total
      camera[m.to_s]  = -@user.transactions.valid.not_nae.month(year, m).category_id( 9620456).total
      travel[m.to_s]  = -@user.transactions.valid.not_nae.month(year, m).category_id( 9620476).total
      night[m.to_s]   = -@user.transactions.valid.not_nae.month(year, m).category_id(29363524).total
      darts[m.to_s]   = -@user.transactions.valid.not_nae.month(year, m).category_id(70703902).total
    end
    sum_entertainment << { name: 'レジャー',     data: leisure }
    sum_entertainment << { name: 'イベント',     data: event   }
    sum_entertainment << { name: '映画・動画',   data: movie   }
    sum_entertainment << { name: '音楽',         data: music   }
    sum_entertainment << { name: '漫画',         data: comic   }
    sum_entertainment << { name: '書籍',         data: book    }
    sum_entertainment << { name: 'ゲーム',       data: game    }
    sum_entertainment << { name: 'ホテル',       data: hotel   }
    sum_entertainment << { name: '温泉・銭湯',   data: spring  }
    sum_entertainment << { name: 'カラオケ',     data: karaoke }
    sum_entertainment << { name: '寺社仏閣',     data: temple  }
    sum_entertainment << { name: 'ネットカフェ', data: netcafe }
    sum_entertainment << { name: 'おもちゃ',     data: toy     }
    sum_entertainment << { name: 'カメラ',       data: camera  }
    sum_entertainment << { name: '旅行',         data: travel  }
    sum_entertainment << { name: '風俗',         data: night   }
    sum_entertainment << { name: 'ダーツ',       data: darts   }

    sum_entertainment_yearly << { name: 'レジャー',     data: { '支出' => leisure.values.inject(:+) } }
    sum_entertainment_yearly << { name: 'イベント',     data: { '支出' => event.values.inject(:+) } }
    sum_entertainment_yearly << { name: '映画・動画',   data: { '支出' => movie.values.inject(:+) } }
    sum_entertainment_yearly << { name: '音楽',         data: { '支出' => music.values.inject(:+) } }
    sum_entertainment_yearly << { name: '漫画',         data: { '支出' => comic.values.inject(:+) } }
    sum_entertainment_yearly << { name: '書籍',         data: { '支出' => book.values.inject(:+) } }
    sum_entertainment_yearly << { name: 'ゲーム',       data: { '支出' => game.values.inject(:+) } }
    sum_entertainment_yearly << { name: 'ホテル',       data: { '支出' => hotel.values.inject(:+) } }
    sum_entertainment_yearly << { name: '温泉・銭湯',   data: { '支出' => spring.values.inject(:+) } }
    sum_entertainment_yearly << { name: 'カラオケ',     data: { '支出' => karaoke.values.inject(:+) } }
    sum_entertainment_yearly << { name: '寺社仏閣',     data: { '支出' => temple.values.inject(:+) } }
    sum_entertainment_yearly << { name: 'ネットカフェ', data: { '支出' => netcafe.values.inject(:+) } }
    sum_entertainment_yearly << { name: 'おもちゃ',     data: { '支出' => toy.values.inject(:+) } }
    sum_entertainment_yearly << { name: 'カメラ',       data: { '支出' => camera.values.inject(:+) } }
    sum_entertainment_yearly << { name: '旅行',         data: { '支出' => travel.values.inject(:+) } }
    sum_entertainment_yearly << { name: '風俗',         data: { '支出' => night.values.inject(:+) } }
    sum_entertainment_yearly << { name: 'ダーツ',       data: { '支出' => darts.values.inject(:+) } }

    [sum_entertainment, sum_entertainment_yearly]
  end

  def sum_group(year: 2020)
    sum_group = []
    travel = {}
    hotel = {}
    traffic = {}
    meal = {}
    others = {}
    Group.where(created_at: Time.new(year, 1, 1).all_year).order(:created_at).each do |record|
      # group名のプレフィックスを取り除く
      name = record[:name].sub(/\d{4}_/, '')

      travel[name]  = -@user.transactions.valid.not_nae.group_id(record[:id]).category_id(9620476).total
      hotel[name]   = -@user.transactions.valid.not_nae.group_id(record[:id]).category_id(4884823).total
      traffic[name] = -@user.transactions.with_category.valid.not_nae.group_id(record[:id]).parent_id(769344).total
      meal[name]    = -@user.transactions.with_category.valid.not_nae.group_id(record[:id]).parent_id(769342).total
      others[name]  = -@user.transactions.valid.not_nae.group_id(record[:id]).total - travel[name] - hotel[name] - traffic[name] - meal[name]
    end
    sum_group << { name: '旅行',   data: travel }
    sum_group << { name: 'ホテル', data: hotel }
    sum_group << { name: '交通費', data: traffic }
    sum_group << { name: '食費',   data: meal }
    sum_group << { name: 'その他', data: others }
  end
end
