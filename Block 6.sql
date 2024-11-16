Task №6.4

SELECT team, day,
       (SELECT SUM(score_points)
	    FROM Scores
		WHERE team = S.team AND day <= S.day
 	   ) AS total
FROM Scores AS S
ORDER BY team, day