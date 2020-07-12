class NullSite
  delegate_missing_to :@site
  def initialize
    @site = Site.new
  end
end
