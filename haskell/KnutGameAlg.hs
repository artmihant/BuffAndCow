module KnutGameAlg where

--import GuessNumberGame (Answer, answerSpace, Result(Win), resultSpace, Outcome(Outcome, Wrong), check, dialog, gameStart, gameEnd)
-- import WordGame (Answer, answerSpace, Result(Win), resultSpace, Outcome(Outcome, Wrong), check, dialog, gameStart, gameEnd)
import BuffCowGame (History, Answer, fullAnswerSpace, Result(Win), resultSpace, Outcome(Outcome, Wrong), check, dialog, gameStart, gameEnd)

game :: ( History -> Answer ) -> History -> History
game strategy history
    | res == Win = newHistory
    | overwise   = game strategy newHistory
    where
        answer = strategy history
        result = test answer
        newHistory = appendHistory history
        appendHistory (History xs) = History ((answer, result):xs)


playGame :: IO ()
playGame = do 
    putStrLn $ game strategy []

playGame :: IO ()
playGame = do
    gameStart
    outcome <- gameIter check dialog answerSpace 0
    gameEnd outcome

gameIter :: (Answer -> Answer -> Result) ->
    (Answer -> IO Result) -> [Answer] -> Int -> IO Outcome

gameIter check dialog answerSpace attempt
    | not $ null answerSpace = do
--        let myAnswer = if (length answerSpace < 1000)
--            then minmaxGameAlg answerSpace check
--            else firstGameAlg answerSpace check
        let myAnswer = head answerSpace
        res <- dialog myAnswer
        if res == Win
            then return $ Outcome (attempt+1) myAnswer
            else gameIter check dialog
                [trueAnswer | trueAnswer <- answerSpace, (check trueAnswer myAnswer) == res] (attempt+1)
    | True = return Wrong

--firstGameAlg :: [Answer] -> (Answer -> Answer -> Result) -> Answer
--firstGameAlg answerSpace check = head answerSpace

--minmaxGameAlg :: [Answer] -> (Answer -> Answer -> Result) -> Answer
--minmaxGameAlg answerSpace check = pointAnswer where
--    pointAnswer = fst $ foldr minAnsw (head answerSpace, length answerSpace) table
--    table = [(
--        myAnswer,
--        (maxList . count) [check myAnswer trueAnswer | trueAnswer <- answerSpace])
--        | myAnswer <- answerSpace]
--
--    maxList = foldr max 0
--
--    minAnsw (a, x) (b, y) = if x < y then (a,x) else (b,y)
--
--    count :: [Result] -> [Int]
--    count results = foldl summ ini results
--        where
--            ini = take (length resultSpace) [0,0..]
--            summ acc result = [if result == resultSpace!!i
--                then num+1
--                else num
--                | (i,num)<-(zip [0..] acc)]

--minmax :: [Answer] -> (Answer -> Answer -> Result) -> Answer
--minmax answerSpace check = fst $
--    foldr (\(a, x) (b, y) ->
--        if x < y then (a,x) else (b,y)
--    ) (head answerSpace, length answerSpace) [(
--        myAnswer,
--        foldl max 0 $
--            foldl (\acc result -> [
--                if result == resultSpace !! i
--                then num+1
--                else num
--            | (i,num)<-(zip [0..] acc) ]) (take (length resultSpace) [0,0..])
--            [check myAnswer trueAnswer | trueAnswer <- answerSpace]
--    )| myAnswer <- answerSpace ]
--
