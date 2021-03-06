-- |
-- Module      : Acme.Pointful
-- Copyright   : (c) 2014 Antonio Nikishaev
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
-- It won't work with big numbers (and it won't even try to prevent
-- incorrect results).  Up to 7 digits is ok.
-- 
-- Don't use if your code is not pointless enough.
-- 
-- Don't use if you care about the trailing zeros (in all the parts
-- after first point). They may be insignificant. Sometimes.

{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}


module Acme.Pointful (Pointful,
                      id,(.)) where

import Prelude hiding (id,(.))
import Numeric
import Control.Category
import Data.List.Split


data Chuwabra a b = Pointful [Integer]
                    deriving Show

type (+) = Chuwabra
type Pointful = () + ((),())


instance Num (Chuwabra a b) where
    fromInteger = Pointful . (:[])
    abs    = undefined
    signum = undefined
    negate = undefined
    (+)    = undefined
    (*)    = undefined


instance Category Chuwabra where
    id = Pointful []
    Pointful a . Pointful b = Pointful $ a++b

instance Num (Chuwabra a b) => Fractional (Chuwabra a b) where
    fromRational = Pointful . map read . splitOn "." . flip (showFFloat Nothing) "" . fromRational
    recip        = undefined


-- So how in the hell this bloody magic works
--
--   1        is fromInteger 1 ∷ Pointful
--   3.14     is fromRational (157 % 50)
--   3.14.159 is 3.14 . 159
--            etc
--

