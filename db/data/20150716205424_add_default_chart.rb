class AddDefaultChart < SeedMigration::Migration
  def up
    Chart.create
  end

  def down
  end
end
