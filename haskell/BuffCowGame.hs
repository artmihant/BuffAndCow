module BuffCowGame where
import Data.List

-- тип ответа --
data Answer where
  Answer :: [Char] -> Answer
  deriving (Eq, Ord, Read)

charList = "123456789"

testAnswer = Answer "9856"
wordLength = lengthAnswer testAnswer where
    lengthAnswer (Answer x) = length x

test = check testAnswer

instance Show Answer where
    show (Answer x) = show x


data Result where
  Result :: (Int, Int) -> Result
  Win :: Result
  deriving (Eq, Ord, Read)

instance Show Result where
    show (Result (x,y)) = show x ++ " быков, " ++ show y ++ " коровы"
    show Win = "Да!"

fullResultSpace = [ Result (i,j) | i <- [0..wordLength], j <- [0..wordLength], k <- [0..wordLength], i+j+k == wordLength ]

data History where
  History :: [(Answer, Result)] -> History

instance Show History where
    show (History []) = ""
    show (History [(a,r)]) = show a ++ " (" ++ show r ++ ")"
    show (History (x1:x2:xs)) = show (History (x2:xs)) ++ " -> \n" ++ show (History [x1])


check :: Answer -> Answer -> Result
check (Answer a) (Answer b) =
    if a == b then Win
    else Result (hint a b)
    where
        hint :: [Char] -> [Char] -> (Int, Int)
        hint a b = (buff, cow)
            where
                buff = length (filter (uncurry (==)) (zip a b))
                cow = length c - buff - length (nub c)
                c = a ++ b


fullAnswerSpace = map Answer (genAnswerSpace charList wordLength)
    where
        genAnswerSpace :: [Char] -> Int -> [[Char]]
        genAnswerSpace charList 0 = [""]
        genAnswerSpace charList wordLength =  concat [map (c:) $
            genAnswerSpace (del charList c) (wordLength-1) | c <- charList]

        del :: (Eq a) => [a] -> a -> [a]
        del [] _ = []
        del (x:xs) y = if x==y then xs else x:del xs y


strategy :: History -> Answer
strategy history = let
    filterAnswerSpace :: History -> [Answer] -> [Answer]
    filterAnswerSpace (History []) answerSpace = answerSpace
    filterAnswerSpace (History ((ans,res):xs)) answerSpace =
        filterAnswerSpace (History (xs)) [answer | answer <- answerSpace, (check ans answer) == res]
    in head $ filterAnswerSpace history fullAnswerSpace


-- dialog :: Answer -> IO Result
-- dialog a = do
--     putStrLn $ show a ++ "?"
--     putStrLn $ show $ result a
--     return $ result a
--     where
--         result = check testAnswer


--dialog :: Answer -> IO Result
--dialog a = do
--    putStrLn $ show a ++ "?"
--    line <- getLine
--    return (parse line)
--    where
--        parse :: String -> Result
--        parse "Yes" = Win
--        parse x = if buff == 4 then Win else Result (buff,cow)
--            where
--                buff :: Int
--                buff = read [head x]
--                cow :: Int
--                cow = read [last x]

-- gameStart :: IO ()
-- gameStart = putStrLn $ "Привет! Быки и коровы!"


-- gameEnd :: Outcome -> IO ()
-- gameEnd Wrong = putStrLn "Что-то пошло не так..."
-- gameEnd (Outcome attempt answer) = putStrLn $
--         "Ваше число " ++ show answer ++ " отгадано за " ++ show attempt ++ " попыток!"
