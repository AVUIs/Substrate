(ns substrate.core
  (:require [quil.core :as q]
            [quil.middleware :as m]
            [substrate.dynamic :as dynamic]))

(q/defsketch substrate-quil
  :title "You spin my circle right round"
  :size [500 500]
  ; setup function called only once, during sketch initialization.
  :setup dynamic/setup
  ; update is called on each iteration before draw is called.
  ; It updates sketch state.
  :update dynamic/update
  :draw dynamic/draw
  ; This sketch uses functional-mode middleware.
  ; Check quil wiki for more info about middlewares and particularly
  ; fun-mode.
  :middleware [m/fun-mode])
