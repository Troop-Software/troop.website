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
  has_many :scout_positions
  has_many :positions, through: :scout_positions


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

  def calc_rank_complete
    self.rank_id += 1
    requirements_for_rank = Requirement.where(rank_id: self.rank_id)
    completed_requirement_count = 0
    requirements_for_rank.each do |req|
      completed_requirement = ScoutRequirement.where(requirement_id: req.id, scout_id: self.id)
      completed_requirement_count += 1 unless completed_requirement.empty?

    end
    total_requirements_needed = requirements_for_rank.count.to_f

   case self.rank_id
     when 6,7,8
      eagle_mb_earned = 0
      elect_mb_earned = 0
      eagle_mb_required = eagle_merit_badges_required(self.rank_id)
      elect_mb_required = elective_merit_badges_required(self.rank_id)
      total_requirements_needed += eagle_mb_required + elect_mb_required
      earned_mbs = ScoutMeritBadge.where(scout_id: self.id)
      earned_eagle_mb= {}
      earned_mb = {}
      earned_mbs.each do |smb|
        if (earned_eagle_mb.key?('Swimming') && (smb.merit_badge.name == 'Hiking' || smb.merit_badge.name == 'Cycling')) ||
            (earned_eagle_mb.key?('Hiking') && (smb.merit_badge.name == 'Swimming' || smb.merit_badge.name == 'Cycling')) ||
            (earned_eagle_mb.key?('Cycling') && (smb.merit_badge.name == 'Hiking' || smb.merit_badge.name == 'Swimming')) ||
            (earned_eagle_mb.key?('Emergency Preparedness') && smb.merit_badge.name == 'Life Saving') ||
            (earned_eagle_mb.key?('Life Saving') && smb.merit_badge.name == 'Emergency Preparedness') ||
            (earned_eagle_mb.key?('Environmental Science') && smb.merit_badge.name == 'Sustainability') ||
            (earned_eagle_mb.key?('Sustainability') && smb.merit_badge.name == 'Environmental Science')

          earned_mb[smb.merit_badge.name] = smb.completed
        else
          earned_eagle_mb[smb.merit_badge.name] = smb.completed if smb.merit_badge.eagle_required
        end
        earned_mb[smb.merit_badge.name] = smb.completed unless smb.merit_badge.eagle_required
      end

        eagle_mb_earned = earned_eagle_mb.count
        elect_mb_earned = earned_mb.count

      eagle_mb_earned = eagle_mb_required if eagle_mb_earned > eagle_mb_required
      elect_mb_earned = elect_mb_required if elect_mb_earned > elect_mb_required
      completed_requirement_count += eagle_mb_earned + elect_mb_earned
      # Do not count requirement for merit badges for progress bad
      total_requirements_needed -= 1
    end

    puts "~="*79
    puts completed_requirement_count
    puts total_requirements_needed
    puts completed_requirement_count / total_requirements_needed
    puts "~="*79

    self.rank_id -= 1
    (completed_requirement_count / total_requirements_needed) * 100

  end

  def elective_merit_badges_required(rank_id)
    case rank_id
      when 6
        2
      when 7
        4
      when 8
        8
      else
        0
    end
  end

  def eagle_merit_badges_required(rank_id)
    case rank_id
      when 6
        4
      when 7
        7
      when 8
        13
      else
        0
    end
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
