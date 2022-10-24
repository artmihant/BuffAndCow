module GuessNumberGame where

data Answer = Answer Int deriving (Eq, Ord, Read)

instance Bounded Answer where
    minBound = Answer 1
    maxBound = Answer 3000

instance Enum Answer where
    toEnum i = Answer i
    fromEnum (Answer i) = i

instance Show Answer where
    show (Answer x) = show x

answerSpace = takeWhile (\i -> i < maxBound) ([minBound..] :: [Answer]) ++ [maxBound]

data Result = Small | Large | Win deriving (Eq, Ord, Read, Show)

instance Bounded Result where
    minBound = Small
    maxBound = Win

instance Enum Result where
    toEnum 0 = Small
    toEnum 1 = Large
    toEnum 2 = Win
    fromEnum Small = 0
    fromEnum Large = 1
    fromEnum Win = 2

resultSpace = takeWhile (\i -> i < maxBound) ([minBound..] :: [Result]) ++ [maxBound]

data Outcome = Outcome Int Answer | Wrong
    deriving (Eq, Ord, Read, Show)

check :: Answer -> Answer -> Result
check a b
    | a == b = Win
    | a < b  = Small
    | a > b  = Large

dialog :: Answer -> IO Result
dialog a = do
    putStrLn $ "Это " ++ show a ++ "?"
    line <- getLine
    return (parse line)
    where
        parse :: String -> Result
        parse "Да" = Win
        parse "<" = Small
        parse "Меньше" = Small
        parse ">" = Large
        parse "Больше" = Large
        parse x = read x

gameStart :: IO ()
gameStart = putStrLn $ "Привет! Загадайте число от " ++ show (minBound::Answer) ++ " до " ++ show (maxBound::Answer) ++ ", а я попробую отгадать!"


gameEnd :: Outcome -> IO ()
gameEnd Wrong = putStrLn "Что-то пошло не так..."
gameEnd (Outcome attempt answer) = putStrLn $
        "Ваше число " ++ show answer ++ " отгадано за " ++ show attempt ++ " попыток!"
