trvrgur
=======
###an imgur clone###
lovingly built by mine own hands from the fertile ground on upward  
in Rails (and eventually Backbone)  
aided by a multitude of libraries most useful  

TODO:  
  set up NewRelic  
  devise/omni-auth?  
    -email confirmation?
    -password change/recovery functionality?  
  entry point into Backbone app?  
  nesting of objects coming in from backbone?  
  top nav bar thing => sign in / sign up / sign out / create album / random  
  
  refactor to use form helpers?  
    -also just refactor to not be bad code  
  good validations for username/email (regex :( )  
  image size/type validations  
  fix validation error message for user password_digest  
    -also "login unsuccessful" displays twice after two failed attempts  
  hash image filenames/urls (or change default)?  
  proper nested routing of images/albums/comments?/general routing design  
  add new images on album edit page?  
  actually finish comments (edit/update)   
  prevent duplicate replies when clicking really fast?  
  allow user only one vote (but they can retract it) (currently one of each)  