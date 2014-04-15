> {-# LANGUAGE UnicodeSyntax #-}

> import Prelude hiding ((.))
> import Acme.Pointful       -- re-exports Control.Category's (.)
>
>
> ghc, ip ∷ Pointful
>
> ghc = 7.8.2                -- ≡ Pointful [7,8,2]
> ip  = 192.168.100.1

