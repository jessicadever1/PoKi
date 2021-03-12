/* 1. What grades are stored in the database? */

Select * FROM Grade;
-- ANSWER: First- Fifth

/* 2. What emotions may be associated with a poem? */
SELECT * FROM Emotion;
SELECT COUNT(Emotion.Id) AS NumOfEmotions
FROM Emotion;
--ANSWER: 4 emotions, Anger Fear Sadness & Joy

/* 3. How many poems are in the database? */
SELECT COUNT(Poem.Id) AS NumOfPoems
FROM Poem;
--ANSWER: 32842

/* 4. Sort authors alphabetically by name. What are the names of the top 76 authors? */
SELECT TOP 76
Author.Name
FROM Author
ORDER BY Author.Name;
--ANSWER: 

/* 5. Starting with the above query, add the grade of each of the authors. */
SELECT TOP 76
Author.Name AS AuthorName,
Grade.Name AS Grade
FROM Author
LEFT JOIN Grade ON Author.GradeId = Grade.Id
ORDER BY Author.Name;

--ANSWER:

/* 6. Starting with the above query, add the recorded gender of each of the authors. */
SELECT TOP 76
Author.Name AS AuthorName,
Grade.Name AS Grade,
Gender.Name AS Gender
FROM Author
LEFT JOIN Grade ON Author.GradeId = Grade.Id
LEFT JOIN Gender ON Author.GenderId = Gender.Id
ORDER BY Author.Name;

--ANSWER:

/* 7. What is the total number of words in all poems in the database? */
SELECT 
SUM(WordCount)
FROM Poem;
--ANSWER: 374,584

/* 8. Which poem has the fewest characters? */
SELECT TOP 1 *
FROM Poem
ORDER BY CharCount ASC;

--OR

SELECT *
FROM Poem
	WHERE CharCount = (
	SELECT MIN(CharCount)
	FROM Poem);

--ANSWER: Poem Id: 123

/* 9. How many authors are in the third grade? */
SELECT COUNT(Author.Id) AS NumOfThirdGraders
FROM Author
LEFT JOIN Grade ON Author.GradeId = Grade.Id
WHERE Grade.Id = 3;

--ANSWER: 2344

/* 10. How many authors are in the first, second or third grades? */
SELECT COUNT(Author.Id) AS NumOfFirstSecThirdGraders
FROM Author
LEFT JOIN Grade ON Author.GradeId = Grade.Id
WHERE Grade.Id = 1 OR Grade.Id = 2 OR Grade.Id = 3;

--ANSWER: 4404

/* 11. What is the total number of poems written by fourth graders? */
SELECT COUNT(Author.Id) AS NumOfFourthGradePoems
FROM Poem
LEFT JOIN Author ON Poem.AuthorId = Author.Id
LEFT JOIN Grade ON Author.GradeId = Grade.Id
WHERE Grade.Id = 4;

--ANSWER: 10,806

/* 12. How many poems are there per grade? */
SELECT COUNT(Grade.Id) AS PoemsPerGrade, Grade.Name
FROM Poem
LEFT JOIN Author ON Poem.AuthorId = Author.Id
LEFT JOIN Grade ON Author.GradeId = Grade.Id
GROUP BY Grade.Name
ORDER BY Grade.Name;

--ANSWER: First: 886, Second: 3160, Third: 6636, Fourth: 10806, Fifth: 11354

/* 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade) */
SELECT COUNT(Author.GradeId) AS AuthorsPerGrade, Grade.Name 
FROM Author
LEFT JOIN Grade on Author.GradeId = Grade.Id
GROUP BY Grade.Name
ORDER BY Grade.Name;

--ANSWER: First: 623, Second: 1437, Third: 2344, Fourth: 3288, Fifth: 3464

/* 14. What is the title of the poem that has the most words? */
SELECT TOP 1
Title,
WordCount
FROM Poem
ORDER BY WordCount DESC;

--or

SELECT 
Title,
WordCount
FROM Poem
	WHERE Poem.WordCount = (
	SELECT MAX(WordCount)
	FROM Poem);

--ANSWER: The Misterious Black


/* 15. Which author(s) have the most poems? (Remember authors can have the same name.) */
SELECT COUNT(Author.Id) AS PoemsPerAuthor, Author.Name AS AuthorName
FROM Poem
LEFT JOIN Author ON Poem.AuthorId = Author.Id
GROUP BY Author.Name
HAVING COUNT(Author.Id) > 1
ORDER BY COUNT(Author.Id) DESC;

--ANSWER: emily

SELECT *
FROM Poem
LEFT JOIN Author ON Poem.AuthorId = Author.Id
WHERE Author.Name = 'a'; 

/* 16. How many poems have an emotion of sadness? */
SELECT COUNT(PoemEmotion.PoemId) AS PoemsOfSadness
FROM PoemEmotion
WHERE PoemEmotion.EmotionId = 3;
-- ANSWER: 14,570

/* 17. How many poems are not associated with any emotion? */
SELECT COUNT(Poem.Id) AS EmotionlessPoems
FROM PoemEmotion
LEFT JOIN Poem ON PoemEmotion.PoemId = Poem.Id
WHERE PoemEmotion.PoemId IS NULL OR PoemEmotion.PoemId = '';

SELECT COUNT(Poem.Id) AS EmotionlessPoems
FROM Poem
LEFT JOIN PoemEmotion on Poem.id = PoemEmotion.PoemId
WHERE PoemEmotion.PoemId IS NULL;

/* 18. Which emotion is associated with the least number of poems? */
SELECT COUNT(EmotionId) AS NumOfPoems, Emotion.Name
FROM PoemEmotion
	LEFT JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
	GROUP BY Emotion.Name
	ORDER BY COUNT(EmotionId) ASC;

--ANSWER: Anger

/* 19. Which grade has the largest number of poems with an emotion of joy? 
COUNT(Grade.Name)
*/
SELECT
Grade.Name AS GradeName,
Emotion.Name AS Emotion,
COUNT(Emotion.Id) AS NumOfJoyPoems
FROM PoemEmotion
 JOIN Poem ON PoemEmotion.PoemId = Poem.Id
 JOIN Author ON Poem.AuthorId = Author.Id
 JOIN Grade ON Author.GradeId = Grade.Id
 JOIN Emotion On PoemEmotion.EmotionId = Emotion.Id
WHERE Emotion.Id = 4
GROUP BY Grade.Name, Emotion.Name
ORDER BY COUNT(Emotion.Id) DESC;




/* 20. Which gender has the least number of poems with an emotion of fear? */
SELECT 
Gender.Name,
Emotion.Name
FROM PoemEmotion
LEFT JOIN Author ON Poem.AuthorId = Author.Id
LEFT JOIN Gender ON Author.GenderId = Gender.Id
LEFT JOIN Poem ON Poem;
