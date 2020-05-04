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
    #investing = {}
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
      #investing[m.to_s]     = -@user.transactions.with_category.valid.not_nae.source(source).month(year, m).parent_id(25117604).total
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
    #sum_category << { name: '投資・財テク', data: investing     }
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
    #sum_category_yearly << { name: '投資・財テク', data: { '支出' => investing.values.inject(:+) } }
    sum_category_yearly << { name: 'ギャンブル',   data: { '支出' => gamble.values.inject(:+) } }
    sum_category_yearly << { name: '収入',         data: { '収入' => income.values.inject(:+) } }

    [sum_category, sum_category_yearly]
  end
end
