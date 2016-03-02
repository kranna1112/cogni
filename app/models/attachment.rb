class Attachment < ActiveRecord::Base
  STATUSES = %w(uploading finished)

  STATUSES.each do |s|
    define_method(s + '?') { self.status.to_s == s }
  end

  scope :complete, -> { where(status: 'finished') }

  belongs_to :attachable, :polymorphic => true
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  validates :name, presence: true
  validates :size, presence: true
  validates :attachable, presence: true
  validates :acl, presence: true, inclusion: { in: %w(private public-read) }

  # before_create :generate_uuid
  before_create :generate_uuid, :unless => :private?
  before_destroy :delete_file!

  def private?
    self.acl == 'private'
  end

  def s3_key
    if private?
      "#{s3_key_prefix}/#{id}-#{name}"
    else
      "#{s3_key_prefix}/#{uuid}-#{id}-#{name}"
    end
  end

  def s3_upload_key
    if private?
      "#{s3_key_prefix}/#{id}-${filename}"
    else
      "#{s3_key_prefix}/#{uuid}-#{id}-#{name}"
    end
  end

  def s3_key_prefix
    "tenants/#{tenant_id}/attachments/#{attachable_type}/#{attachable_id}"
  end

  # "projects/#{attachable.project_id}/attachments/#{attachable_type}/#{attachable_id}/#{uuid}-#{id}-#{name}"
  # end

  def s3_policy
    policy = S3.policy(self)
    signature = S3.signature(policy)

    {
        policy: policy,
        signature: signature,
        # key: self.s3_key,
        key: self.s3_upload_key,
        action: S3.base_uri,
        key_id: Setting.s3.key_id,
        acl: self.acl,
        success_action_status: 200
    }
  end

  def create_download_url!
    disposition = "attachment; filename=#{self.name}"
    S3.bucket.objects[s3_key].url_for(:read, :response_content_disposition => disposition, :response_content_type => content_type).to_s
  end

  # access url, only useful for public attachments
  # protocol: http | https
  def url(protocol = "https")
    if protocol.present?
      "#{protocol}:#{S3.base_uri}/#{s3_key}"
    else
      "#{S3.base_uri}/#{s3_key}"
    end
  end

  private

  def delete_file!
    S3.delete_object(self.s3_key)
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

end
