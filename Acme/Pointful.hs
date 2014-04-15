-- |
-- Module      : Acme.Pointful
-- Copyright   : (c) 2014 Anton Nikishaev
--
-- License     : BSD-style
-- Maintainer  : a@lelf.me
-- 
-- This module allows you to make more points in your numbers
-- 
-- > import Prelude hiding ((.))
-- > import Acme.Pointful       -- re-exports Control.Category's (.)
-- >
-- >
-- > ghc, ip ∷ Pointful
-- >
-- > ghc = 7.8.2                -- ≡ Pointful [7,8,2]
-- > ip  = 192.168.100.1
-- 
-- Don't use if your code is not pointless enough.

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

