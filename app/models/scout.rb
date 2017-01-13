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
  has_many :youth_trainings
  has_many :scout_trainings, through: :youth_trainings
  has_one :address, :as => :addressable
  accepts_nested_attributes_for :address
  has_many :scout_awards
  has_many :youth_awards, through: :scout_awards
  after_create :establish_scout_rank_history


  def self.allowed_scouts(user)
    return Scout.where(active: true) if user.role?(:leader)
    return Scout.where(active: true) if user.role?(:leader_full)
    return Scout.all if user.role?(:admin)
    Scout.joins(:relationships).where('relationships.user_id = ?', user)
  end

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
    if self.rank_completion.blank?
      recalc_rank_complete
    end
    return self.rank_completion
  end

  def recalc_rank_complete
    self.rank_id += 1
    requirements_for_rank = Requirement.where(rank_id: self.rank_id)
    completed_requirement_count = 0
    requirements_for_rank.each do |req|
      completed_requirement = ScoutRequirement.where(requirement_id: req.id, scout_id: self.id)
      completed_requirement_count += 1 unless completed_requirement.empty?

    end
    total_requirements_needed = requirements_for_rank.count.to_f

    case self.rank_id
      when 6, 7, 8
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

    self.rank_id -= 1
    self.rank_completion = (completed_requirement_count / total_requirements_needed) * 100
    self.save
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

  def current_rank_date
    self.scout_rank_histories.find_by_rank_id(self.rank_id).rank_completed
  end

  def active_positions
    positions = []
    self.scout_positions.each do |scout_position|
      positions << scout_position.position.name if scout_position.current_position?
    end
    positions.join(', ')
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
                    scout.birthdate, scout.rank.name, scout.active_positions, scout.patrol.name]
          end
        else
          csv << ["#{report} not found"]
      end
    end
  end

  require 'net/http'

  def self.import_scout(file_id)
    file ='https:' + Admin::FileUpload.find(file_id).file.url

    CSV.new(open(file), headers: true).each do |row|
      name = scout_name(row['First Name'], row['Last Name'])
      scout_record = Scout.find_or_initialize_by(name: name)
      (row['Joined Unit'].blank?) ? joined_date = '' : joined_date = Date.strptime(row['Joined Unit'], '%m/%d/%y')
      scout_record.update(name: name,
                          grade: row['Grade'],
                          birthdate: Date.strptime(row['Date of Birth'], '%m/%d/%y'),
                          rank_id: Rank.find_by_name(rank(row['Current Rank'])).id,
                          email: row['Email #1'],
                          phone: row['Home Phone'],
                          bsa_id: row['BSA ID#'],
                          joined: joined_date,
                          patrol: Patrol.find(patrol_id(row['Patrol']).id)
      )
      # Import Scout's Address
      scout_address = Address.find_or_initialize_by(addressable_id: scout_record.id, addressable_type: 'Scout')
      scout_address.update(line1: row['Home Address Line 1'],
                           line2: row['Home Address Line 2'],
                           city: row['Home City'],
                           state: row['Home State'],
                           zip: row['Home Zip']
      )
      # Import Scout's Leadership Positions
      unless row['Leadership Pos #1'].nil?
        ScoutPosition.find_or_create_by(scout_id: Scout.find_by_name(name).id,
                                        position_id: Position.find_by_name(convert_position(row['Leadership Pos #1'])).id,
                                        start_date: Date.strptime(row['Leadership Pos Date #1'], '%m/%d/%y')
        )
        unless row['Leadership Pos #2'].nil?
          ScoutPosition.find_or_create_by(scout_id: Scout.find_by_name(name).id,
                                          position_id: Position.find_by_name(convert_position(row['Leadership Pos #2'])).id,
                                          start_date: Date.strptime(row['Leadership Pos Date #2'], '%m/%d/%y')
          )
        end
      end
    end
  end

  def self.convert_position(position_name)
    case position_name
      when 'Leave No Trace Tnr'
        position_name = 'Outdoor Ethics Guide'
      when 'Asst Patrol Ldr'
        position_name = 'Asst Patrol Leader'
      when 'Asst SPL'
        position_name = 'Assistant Senior Patrol Leader'
      when 'Senior Patrol Ldr'
        position_name = 'Senior Patrol Leader'
      when 'O/A Rep'
        position_name = 'Order Of The Arrow Troop Representative'
    end
    position_name
  end

  def self.rank(rank_name)
    case rank_name
      when nil
        return 'Just Joined'
      when '1st Class'
        return 'First Class'
      when '2nd Class'
        return 'Second Class'
      else
        return rank_name
    end
  end

  def self.patrol_id(patrol_name)
    patrol = Patrol.find_by_name(patrol_name)
    if patrol.nil?
      patrol = Patrol.create(name: patrol_name)
    end
    return patrol
  end

  def self.scout_name(first, last)
    name = ''
    name += first unless first.nil?
    #name += " #{middle}" unless middle.nil?
    name += " #{last}" unless last.nil?
    #name += " #{suffix}" unless suffix.nil?
    return name
  end
end
