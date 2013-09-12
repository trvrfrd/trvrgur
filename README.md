trvrgur
=======
###an imgur clone###
lovingly built by mine own hands from the fertile ground on upward  
in Ruby on Rails and Backbone.js  
aided by a multitude of libraries most useful, including:  

TODO:  
general:  
  - make album title mandatory?  
  - set up NewRelic  
  - devise/omni-auth?  
    - email confirmation?  
    - password change/recovery functionality?  
  - refactor views to use form helpers?  
    - actually just eliminate most erb views probably (use mostly bbone views)  
    - also just refactor to not be bad code  
  - good validations for username/email (regex :( )  
  - image size/type validations  
  - fix validation error message for user password_digest  
    - using flash errors w/bbone?  
  - hash image filenames/urls (or change default)?  
  - proper nested routing of images/albums/comments?/general routing design  
    - prune unnecessary routes/endpoints  
  - actually finish comments (edit/update)  
  - prevent duplicate replies when clicking really fast?  
  - allow user only one vote (but they can retract it) (currently one of each)  
  - make sure database performance/number of queries is not awful  
  - deep linking???? persist state of BB app if visiting Rails pages?  
  - implement swapping router  
  - delete unused bbone routers/views/templates  
  
top nav bar thing:  
  - create album / display random album  

gallery page:  
  - upvote arrow/downvote arrow on hover?  
  - sort by top rated/newest  
  - pagination w/ kaminari  
  
album show page:  
  - handle comments  
    - use model save + change listener instead of callbacks to re-render? 
    - form for new comment   
    - reply (modal form?? async refresh?????)  
    - sort comments by upvotes/newest?  
    - collapsible threads  
    - delete button for own comments  
  - click image to show fullscreen thing whatever 
  - edit album link  
  
album create/edit pages:  
  - adding/removing images  
  - sort order column + jQueryUI sortable  
  - upload multiple photos in one input (shift/ctrl-click)  
    - vs. or in addition to appending multiple file input fields  
