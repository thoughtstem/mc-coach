#lang scribble/manual
@require[@for-label[mc-coach
                    racket/base]]

@title{mc-coach}
@author{thoughtstem}

@defmodule[mc-coach/bio]

Using the language @tt{#lang mc-coach/bio} gives access to @racket[bio] as well as everything from @racket[2htdp/image] and @racket[website/bootstrap].
Running the file will launch a web browser to preview the bio content.

@defproc[(bio [#:name name string?] 
              [#:profile-pic profile-pic image?]
              [#:coach-story coach-story string?]) element?]{
  This generates the HTML element for a MetaCoders coach bio, suitable for inclusion in the main site at metacoders.org.  
  
  It will also automatically provide it out under the identifier @racket[coach-bio] -- suitable for inclusion in other Racket modules.
}
