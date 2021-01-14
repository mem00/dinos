# README

ruby 2.5.1
rails 6.0.3.4

Run `bundle install`

Set up database `rake db:create`
Run migrations `rake db:migrate`

Run tests `rake test`

What to consider for concurrent environment:

• Move conditions to database eg put check on dinosaurs_count in db

• Concurrency control for shared resources (prevent race conditions, resource starvation, and deadlocks) eg putting a dinosaur in a cage that was just turned off

• Possible solution for above example: pessimistic or optimistic locking 
