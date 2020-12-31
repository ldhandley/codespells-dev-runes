#lang at-exp codespells

(require dev-runes/mod-info
         website-js)

; Note: SphereOverlapActors doesn't return all actors. (e.g. particle effects)
; However, particle effects can be destroyed if they are childed to a parent with a mesh.
; Or possibly any actor that "generates overlaps"
; TODO: RESEARCH THIS


(define-classic-rune (on-key-press)
  #:background "green"
  #:foreground (circle 40 'solid 'red)
  (unreal-js @~a{
 (function(){
  class MyIH extends Root.ResolveClass("InputHelper") {
   HandleKeyPressed(key) {
    console.log(key)
   }
  } 

  let MyIH_C = require('uclass')()(global,MyIH);
  new MyIH_C(GWorld);
  })()}))

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

(define-classic-rune (spawn-cube)
  #:background "blue"
  #:foreground (square 40 'solid 'red)
  (unreal-js @~a{
    (function(){
  const uclass = require('uclass')().bind(this,global);
  class MySMA extends StaticMeshActor {
   ctor() {
    this.StaticMeshComponent.SetStaticMesh(StaticMesh.Load('/Engine/BasicShapes/Cube.Cube'))
   }
  }      
  let MySMA_C = uclass(MySMA);
  new MySMA_C(GWorld,{X:@(current-x), Y:@(current-z), Z:@(current-y)});
    })()}))

(define-classic-rune (open-browser url)
  #:background "blue"
  #:foreground (square 40 'solid 'red)
  (unreal-js @~a{
    (function(){
      var widget = GWorld.CreateWidget(WB_TextSpellcrafting_C, GWorld.GetPlayerController(0));
      widget.WebBrowser_309.InitialURL = "@url";
      widget.AddToViewport();
  })()}))

(local-require codespells-ui-demos/util
                   codespells-runes/widgets/main)

(define raw-racket-rune-binding
  (html-rune 'editor:raw
             (raw-code-rune-widget))
  #;(let ()
    
  
    (define (fancy-rune)
      (enclose
       (div
        (svg-rune-description
         (rune-background
          #:color "red"
          (rune-image
           (circle 40 'solid 'green)))))
       (script ()
               (function (makePreview s)
                         @js{console.log("Preview", @s)}))))

    (define (fancy-editor)
      (editor-component "()"))

    (rune+editor->html-rune
     (list (fancy-rune) (fancy-editor)))))

(define-classic-rune-lang my-mod-lang #:eval-from main.rkt
  (destroy-actors
   spawn-cube
   open-browser
   on-key-press
   raw-racket))

(module+ main
  (codespells-workspace ;TODO: Change this to your local workspace if different
   (build-path (current-directory) ".." ".."))
  
  (once-upon-a-time
   #:world (demo-world)
   #:aether (demo-aether
             #:lang (my-mod-lang #:with-paren-runes? #t))))


