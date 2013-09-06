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
  refactor to use form helpers?  
    -also just refactor to not be bad code  
  good validations for username/email (regex :( )  
  entry point into Backbone app?  
  fix validation error message for user password_digest  
    -also "login unsuccessful" displays twice after two failed attempts  
  hash image filenames/urls (or change default)?  
  proper nested routing of images/albums/comments?/general routing design  
  image size/type validations  
  top nav bar thing => sign in / sign up / sign out / create album / random  
  add new images on album edit page?  
  accepts_nested_attributes_for? nesting of objects coming in from backbone?  
  actually finish comments (edit/update)  