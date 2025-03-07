# README

Build an application to track the score of a single game of bowling. The application will accept the result of each ball bowled and calculate the correct score, including spares and strikes. The application must also indicate if the 10th frame includes a third ball.

Results of each roll are input one at a time, sequentially. The application should assign the scores to the correct frames. The application should sanitize inputs to only allow valid scores to be entered at any given time. The score should be updated as the rolls are entered. *Do not* assume all rolls will be entered at once.

## Bowling Game

* A game of bowling consists of 10 frames. Two balls are rolled per frame in an attempt to knock down all ten pins.
* If all ten pins are knocked down in two turns in the 10th frame, an extra roll is awarded.
* A **strike** is defined as knocking down all ten pins in the first roll of a frame. It's indicated with an `X`.
* A **spare** is defined as knocking down all the remaining pins in the second roll of a frame. It's indicated with a `/`.
* A **miss** is defined as zero pins being knocked down on a roll. It's indicated with a `-`.

## Scoring Rules

* Generally, 1 point is awarded per pin knocked down.
* A **strike** scores 10 points (for knocking down all ten pins), plus the total of the next two rolls.
* A **spare** scores 10 points, plus the total number of pins knocked down on the next roll only.
* Each frame displays the cumulative score up to that point for all completed frames. If a frame has a strike or spare, the score for that frame is not displayed until sufficient subsequent rolls have been recorded.
