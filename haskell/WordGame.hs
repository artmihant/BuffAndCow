module WordGame where

newtype Answer = Answer [Char] deriving (Eq, Ord, Read)

instance Show Answer where
    show (Answer x) = show x

charList = "abcdefghijklmnopqrstuvwxyz"
testAnswer = Answer "catalog"
wordl = lengthA testAnswer where
    lengthA (Answer x) = length x

answerSpace = map Answer $ genAnswerSpace charList wordl
    where
        genAnswerSpace :: [Char] -> Int -> [[Char]]
        genAnswerSpace charList 0 = [""]
        genAnswerSpace charList wordLength =  concat [map (c:) $
            genAnswerSpace charList (wordLength-1) | c <- charList]

data Result = Result Int | Win deriving (Eq, Ord, Read)

instance Show Result where
    show (Result x) = show x ++ " буквы"
    show Win = "Да!"

resultSpace = [ Result i | i <- [0..wordl]]

data Outcome = Outcome Int Answer | Wrong
    deriving (Eq, Ord, Read, Show)

check :: Answer -> Answer -> Result
check a@(Answer x) b@(Answer y) =
    if a == b then Win
    else Result (calcWord x y)

calcWord :: [Char] -> [Char] -> Int
calcWord [] _ = 0
calcWord _ [] = 0
calcWord (x:xs) (y:ys) = if x == y then 1 + calcWord xs ys else calcWord xs ys


dialog :: Answer -> IO Result
dialog a = do
    putStr $ show a ++ " - "
    putStrLn $ show $ result a
    return $ result a
    where
        result = check testAnswer


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

gameStart :: IO ()
gameStart = putStrLn $ "Угадай слово!"


gameEnd :: Outcome -> IO ()
gameEnd Wrong = putStrLn "Что-то пошло не так..."
gameEnd (Outcome attempt answer) = putStrLn $
        "Слово " ++ show answer ++ " отгадано за " ++ show attempt ++ " попыток!"
