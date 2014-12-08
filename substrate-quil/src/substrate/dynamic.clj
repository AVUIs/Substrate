(ns substrate.dynamic
  (:require [quil.core :as q]
            [quil.applet :as applet]
            [quil.middleware :as m])
  (:import [ddf.minim Minim]
           [ddf.minim AudioOutput]
           [ddf.minim.signals SineWave]))

(def ^:dynamic *minim* (atom nil))
(def ^:dynamic *outp*  (atom nil))
(def ^:dynamic *sine*  (atom nil))

(defn setup []
  ; Set frame rate to 30 frames per second.
  (q/frame-rate 30)
  ; Set color mode to HSB (HSV) instead of default RGB.
  (q/color-mode :hsb)

  (swap! *minim* (fn [minim] (Minim. (applet/current-applet))))
  (swap! *outp*  (fn [out] (.getLineOut @*minim*)))
  (swap! *sine*  (fn [out] (new SineWave 440 1 (.sampleRate @*outp*))))

  ;; I want something like this, but I don't know how to make it work
  ;; Everything I try ends up with the famous and much loved
  ;; java.lang.NullPointerException.
  ;;
  ;; Bah.
  ;
  ; (.patch *sine* *outp*)

  ; setup function returns initial state. It contains
  ; circle color and position.
  {:color 0
   :angle 0})

(defn update [state]
  ; Update sketch state by changing circle color and position.
  {:color (mod (+ (:color state) 0.7) 255)
   :angle (+ (:angle state) 0.1)})

(defn draw [state]
  ; Clear the sketch by filling it with light-grey color.
  (q/background 240)
  ; Set circle color.
  (q/fill (:color state) 255 255)
  ; Calculate x and y coordinates of the circle.
  (let [angle (:angle state)
        x (* 150 (q/cos angle))
        y (* 150 (q/sin angle))]
    ; Move origin point to the center of the sketch.
    (q/with-translation [(/ (q/width) 2)
                         (/ (q/height) 2)]
      ; Draw the circle.
      (q/ellipse x y 100 100))))
