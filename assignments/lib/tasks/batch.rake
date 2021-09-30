namespace :batch do
  desc "Take backup of database every night"
  task db_backup: :environment do
    # system "pg_dump -U wae -h localhost -F c assignments_development -f ../db_backup.psql"
    # system "pg_dump --dbname=postgresql://wae:password@localhost:5432/assignments_development -f ../db_backup.psql"
    system "pg_dump assignments -f ../db_backup.psql"
  end
end
