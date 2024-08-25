module Util where

import System.IO
import System.Console.ANSI
import System.Process(callCommand)
import Control.Concurrent (threadDelay)
import System.IO.Unsafe (unsafePerformIO)
import Data.List (intercalate)
import Data.List.Split (splitOn)


limparTela :: IO()
limparTela = callCommand "clear"

delay :: IO ()
delay = threadDelay (1 * 1000000) -- 1.0 segundo

lerCaractere :: IO Char
lerCaractere = do
    hSetBuffering stdin NoBuffering
    hSetEcho stdin False
    char <- getChar
    hSetEcho stdin True
    hSetBuffering stdin LineBuffering
    return char

substituiTags :: String -> String
substituiTags = replace "[AZUL]" "\ESC[34m"
            . replace "[DEFAULT]" "\ESC[0m"

replace :: Eq a => [a] -> [a] -> [a] -> [a]
replace old new = intercalate new . splitOn old