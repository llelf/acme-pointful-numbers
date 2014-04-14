{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE FlexibleContexts #-}


import Prelude hiding (id,(.))
import Control.Category
import Data.List.Split
import Debug.Trace

data N a b = N [Integer]
             deriving Show


instance Num (N a b) where
    fromInteger = N . (:[])
    abs    = undefined
    signum = undefined
    (+)    = undefined
    (*)    = undefined


instance Category N where
    id = N []
    N a . N b = N $ a++b

instance Num (N a b) => Fractional (N a b) where
    fromRational = N . map read . splitOn "." . show . fromRational

