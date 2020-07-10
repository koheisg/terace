module Auditable
  extend ActiveSupport::Concern

  included do
    has_many :audits, as: :auditable
    after_create :create_audit_on_create
    after_update :create_audit_on_update
    before_destroy :create_audit_on_destroy

    def create_audit_on_create
      create_audit(:create)
    end

    def create_audit_on_update
      create_audit(:update)
    end

    def create_audit_on_destroy
      create_audit(:destroy)
    end

    private
      def create_audit(action)
        audits.create!(modifications: self, action: action)
      end
  end
end
