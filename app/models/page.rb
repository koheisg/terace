class Page < ApplicationRecord
  include Auditable, Permalinkable, Htmlable
end
