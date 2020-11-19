#lang at-exp codespells

(require dev-runes/mod-info)

; Note: SphereOverlapActors doesn't return all actors. (e.g. particle effects)
; However, particle effects can be destroyed if they are childed to a parent with a mesh.
; Or possibly any actor that "generates overlaps"
; TODO: RESEARCH THIS

(define-classic-rune (destroy-actors [radius 50])
  #:background "blue"
  #:foreground (circle 40 'solid 'red)
  (unreal-js @~a{
 (function(){
   var actors = KismetSystemLibrary.SphereOverlapActors(GWorld, {X:@(current-x), Y:@(current-z), Z:@(current-y)}, @radius).OutActors

   var destroy = function(a){
     a.GetAttachedActors().OutActors.map(destroy)

     a.DestroyActor()                         
   }

   actors.map(destroy)          
  })()
 }))


(define-classic-rune-lang my-mod-lang #:eval-from main.rkt
  (destroy-actors))

(module+ main
  (codespells-workspace ;TODO: Change this to your local workspace if different
   (build-path (current-directory) ".." ".."))
  
  (once-upon-a-time
   #:world (demo-world)
   #:aether (demo-aether
             #:lang (my-mod-lang #:with-paren-runes? #t))))


