class MigrateArticleToPermalink < ActiveRecord::Migration[6.0]
  def up
    sql = <<~SQL
      insert into permalinks
      (permalinkable_type
      , permalinkable_id
      , site_id
      , state
      , path
      , title
      , description
      , noindex
      , published_at
      , modified_at
      , created_at
      , updated_at
      )
      (select 'Article' as permalinkable_type
      , id as permalinkable_id
      , site_id
      , state
      , permalink as path
      , title
      , description
      , noindex
      , published_at
      , modified_at
      , created_at
      , updated_at
      from articles)
      ;
    SQL

		con =  ActiveRecord::Base.connection
		con.execute(sql)
  end
end
