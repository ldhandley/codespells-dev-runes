#lang racket

(provide mod-name pak-folder main.rkt)

(require racket/runtime-path)

(define
  mod-name
  "DevRunes")

(define-runtime-path
  pak-folder
  "BuildUnreal/WindowsNoEditor/DevRunes/Content/Paks/")

(define-runtime-path
  main.rkt
  "main.rkt")


