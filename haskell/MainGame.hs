import BuffCowGame (History(History), Answer, Result(Win), strategy, test)

tabluaRasa = History []
main = print(game strategy tabluaRasa test)

game :: ( History -> Answer ) -> History -> (Answer -> Result) -> History
game strategy history test = let 
        answer = strategy history
        result = test answer
        supplement (History xs) = History ((answer, result):xs)
        newHistory = supplement history
    in 
        if result == Win then newHistory
        else game strategy newHistory test
        

-- Даны конечные множества Answer и Result и функция check :: Answer -> Answer -> Result
-- Существует Win :: Result такое, что check a b == Win <=> a == b
-- Загадана функция test = check a
-- Придумать функцию strategy :: [(Answer, Result)] -> Answer :
-- Такую, что game strategy [] будет равняться не очень большому числу и выполняться за не очень больше время.

