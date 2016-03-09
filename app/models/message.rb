class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  paginates_per 10

  mi_const_set('ACTIONS',
  [
    :LEADER_CONFIRM,
    :LEADER_REJECT,
    :TALK
  ])

  belongs_to :user

  scope :default_order, -> { order('created_at DESC') }
  scope :untreat, -> { where(status: nil).where(must_action: true) }
  scope :treated, -> { where.not(status: nil) }
  scope :unread, -> { where(is_read: nil) }
  scope :unread_or_must_action, -> { where("is_read IS NULL OR (status IS NULL AND must_action = 't')") }

  def is_read?
    !! is_read
  end

  def is_new?
    is_read? && ( DateTime.now - read_at ).to_f < 5
  end

  def is_treat?
    must_action && status
  end

  def done?
    status == 'done' or status == 'accepted'
  end

  def rejected?
    status == 'rejected'
  end

  def done
    self.status = 'done'
    self.save!
  end

  def reject
    self.status = 'rejected'
    self.save!
  end

  def mark_as_read
    self.is_read = true
    self.read_at = DateTime.now
    self.save!
  end  
end
