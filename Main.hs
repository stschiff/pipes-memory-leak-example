import SequenceFormats.Eigenstrat (readEigenstrat)

import Pipes ((>->), runEffect)
import Pipes.Prelude (drain)
import Pipes.Safe (runSafeT)
import System.FilePath.Posix ((<.>))
import System.Environment (getArgs)


main :: IO ()
main = do
    [fn] <- getArgs
    processEigenstrat fn

processEigenstrat :: FilePath -> IO ()
processEigenstrat fn = runSafeT $ do
    (_, prod) <- readEigenstrat (fn <.> "geno") (fn <.> "snp") (fn <.> "ind")
    runEffect $ prod >-> drain

