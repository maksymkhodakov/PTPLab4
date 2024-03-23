import Data.Char (isUpper, isSpace)
import Data.List (groupBy, nubBy, sortBy)
import Data.Function (on)

-- Визначення базових типів
type Symbol = String
type Rule = (Symbol, String)
type Grammar = [Rule]

-- Функція для перевірки, чи є символ нетермінальним
isNonTerminal :: Symbol -> Bool
isNonTerminal = all (\c -> isUpper c || isSpace c)

-- Функція для парсингу правил виводу з рядка
parseRule :: String -> Maybe Rule
parseRule input =
  let (left, right) = break (== ' ') input
  in if isNonTerminal left && not (null right) && length left == 1
     then Just (left, dropWhile isSpace right)
     else Nothing

-- Функція для перевірки, чи є граматика Кореняка-Хопкрофта
isChomskyHopcroft :: Grammar -> Bool
isChomskyHopcroft grammar = all isUniqueFirstSymbols groupedRules
  where
    groupedRules = groupBy ((==) `on` fst) $ sortBy (compare `on` fst) grammar
    isUniqueFirstSymbols rules = (length . nubBy ((==) `on` (take 1 . snd)) $ rules) == length rules

-- Головна функція
main :: IO ()
main = do
  putStrLn "Введіть правила граматики, кожне правило з нового рядка. Завершіть вводом пустого рядка."
  inputLines <- getLines []
  let parsedRules = mapM parseRule inputLines
  case parsedRules of
    Just grammar ->
      if isChomskyHopcroft grammar
      then putStrLn "Граматика є КВ граматикою Кореняка-Хопкрофта."
      else putStrLn "Граматика НЕ є КВ граматикою Кореняка-Хопкрофта."
    Nothing -> putStrLn "Кожне правило має мати один нетермінал ліворуч! Граматика не КВ!"

-- Допоміжна функція для читання багаторядкового вводу
getLines :: [String] -> IO [String]
getLines lines = do
  line <- getLine
  if null line
    then return lines
    else getLines (lines ++ [line])
