Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
  DatabaseCleaner.strategy = :truncation
end

Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
  DatabaseCleaner.strategy = :transaction
end

Before do
  DatabaseCleaner.start
end

After do |scenario|
  DatabaseCleaner.clean
end
