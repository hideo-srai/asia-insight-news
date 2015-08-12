class AddPublishedAtToLink < SeedMigration::Migration
  def up
    Link.all.each { |l| l.published_at = l.created_at; l.save }
  end

  def down

  end
end
