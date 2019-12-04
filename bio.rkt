#lang racket

;As a language, this auto launches a webserver pointing to your bio...

(module reader syntax/module-reader
  mc-coach/bio)

(provide bio  
         (all-from-out 2htdp/image)
         (all-from-out website/bootstrap)
         (except-out (all-from-out racket) #%module-begin)
         (rename-out [my-module-begin #%module-begin]))
(require 2htdp/image website/raco-tools/preview)
(require (except-in website/bootstrap frame))

(define (bio #:name name #:profile-pic (profile-pic (circle 40 'solid 'red)) #:coach-story (coach-story "COACH STORY GOES HERE (use #:coach-story)") #:youtube-link (youtube-link #f))
  (bio-card #:name name
    (row
      (col-2
        (write-img class: "img-fluid rounded mb-3" profile-pic))
      (col-10
        (div coach-story)
        (when youtube-link
         (div class: "pt-2"
          (iframe width: "560" height: "315" 
           src: (~a "https://www.youtube.com/embed/" (extract-youtube-id youtube-link))
           'frameborder: "0" 
           'allow: "accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" 
           'allowfullscreen: #t)))))))

(define (extract-youtube-id l)
  (second (string-split l "v=")))

(define (bio-card #:name name . content)
  (card
    (card-header name)
    (card-body
      (card-text
        content))))

(define (preview-bio bio)
  (list
    (bootstrap-files) 
    (page index.html
          (content 
            (navbar #:brand "Bio Preview")
            (container class: "pt-5" bio)))))

(define-syntax-rule (my-module-begin stuff ... (bio bio-params ...))
  (#%module-begin
    stuff ...
    (provide coach-bio)
    (define coach-bio (bio bio-params ...)) 
    (module+ main
      (render (preview-bio coach-bio) #:to "out")
      (current-directory "out") 
      (preview))))

