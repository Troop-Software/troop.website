class Scout < ApplicationRecord
  validates :name, presence: true, length: {minimum: 3, maximum: 250}
  validates_uniqueness_of :name

  belongs_to :patrol
  belongs_to :rank
  belongs_to :position
  has_many :scout_rank_histories
  has_many :scout_requirements
  has_many :requirements, through: :scout_requirements
  has_many :scout_merit_badges
  has_many :merit_badges, through: :scout_merit_badges
  has_many :scout_events
  has_many :events, through: :scout_events
  has_many :relationships
  has_many :users, through: :relationships


  after_create :establish_scout_rank_history

  def establish_scout_rank_history
    x = 1
    until x > rank.id
      srh = ScoutRankHistory.new(scout_id: self.id, rank_id: x, rank_completed: Date.parse('1/1/1111'))
      puts srh.inspect
      srh.save!
      x += 1
    end
  end

  def calc_rank_percentage
    self.rank_id += 1
    requirements_for_rank = Requirement.where(rank_id: self.rank_id)
    completed_requirement_count = 0
    requirements_for_rank.each do |req|
      completed_requirement = ScoutRequirement.where(requirement_id: req.id, scout_id: self.id)
      completed_requirement_count += 1 unless completed_requirement.empty?

    end
    total_requirements_needed = requirements_for_rank.count.to_f
    if self.rank_id == 6
      eagle_mb_earned = 0
      elect_mb_earned = 0
      eagle_mb_required = 4
      elect_mb_required = 2
      total_requirements_needed += eagle_mb_required + elect_mb_required
      earned_mbs = ScoutMeritBadge.where(scout_id: self.id)
      earned_mbs.each do |earned_mb|
        eagle_mb_earned += 1 if earned_mb.merit_badge.eagle_required
        elect_mb_earned += 1 unless earned_mb.merit_badge.eagle_required
      end
      eagle_mb_earned = eagle_mb_required if eagle_mb_earned > eagle_mb_required
      elect_mb_earned = elect_mb_required if elect_mb_earned > elect_mb_required
      completed_requirement_count += eagle_mb_earned + elect_mb_earned
    end
    puts "~="*79
    puts completed_requirement_count
    puts total_requirements_needed
    puts "~="*79

    self.rank_id -= 1
    (completed_requirement_count / total_requirements_needed) * 100

  end

  def age(birthday)
    # http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
    (Time.now.to_s(:number).to_i - birthday.to_time.to_s(:number).to_i)/10e9.to_i
  end

  def age_out_date(birthday)
    birthday + 18.years
  end

  def days_till_18(birthday)
    (age_out_date(birthday) - Date.today).to_i
  end

  def scout_alert
    # Set Red if less than 180 left till 18 and rank is Life
    return ['danger', 'Less than 3 months till 18th birthday'] if self.rank.name == 'Life' and days_till_18(self.birthdate).between?(0, 180)

    # Set Yellow if less than 274 left and rank is Life
    return ['warning', 'Less than 9 months till 18th birthday'] if self.rank.name == 'Life' and days_till_18(self.birthdate).between?(181, 274)

    return nil
  end

  def self.to_csv(report)
    CSV.generate(headers: true) do |csv|
      case report
        when 'scoutsReport'
          csv << %w{ID NAME GRADE AGE BIRTHDATE RANK POSITION PATROL}
          all.each do |scout|
            csv << [scout.id, scout.name, scout.grade, scout.age(scout.birthdate),
                    scout.birthdate, scout.rank.name, scout.position.name, scout.patrol.name]
          end
        else
          csv << ["#{report} not found"]
      end
    end
  end
end
