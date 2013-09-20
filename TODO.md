TODO:  
general:
  - URL slugs???
  - make album title mandatory?
  - devise/omni-auth?
    - email confirmation?
    - password change/recovery functionality?
  - refactor views to use form helpers?
    - actually just eliminate most erb views probably (use mostly bbone views)
    - also just refactor to not be bad code
  - good validations for username/email (regex :( )
  - image size/type validations?
  - fix validation error message for user password_digest
    - IN FACT, redo errors entirely; using flash errors w/bbone?
  - hash image filenames/urls (or change default)?
  - proper nested routing of images/albums/comments?/general routing design
    - prune unnecessary routes/endpoints
  - actually finish comments (edit/update)
  - prevent duplicate replies when clicking really fast?
  - allow user only one vote (but they can retract it) (currently one of each)
  - make sure database performance/number of queries is not awful
    - esp. during upvoting/downvoting of comments/albums
  - implement swapping router
  - delete unused bbone routers/views/templates
  
albums index page:
  - upvote arrow/downvote arrow on hover?
  - sort by top rated/newest/most discussed
    - is this the controller's responsibility? GET to nested resource?
  - pagination w/ kaminari
  - cache big initial query w/ Redis
  
album show page:
  - handle comments
    - sort comments by upvotes/newest?
    - collapsible threads
    - delete button for own comments
  
album create/edit pages:
  - sort order column + jQueryUI sortable

user show/edit pages

guest accounts
  - background/delayed job to delete old guests accounts