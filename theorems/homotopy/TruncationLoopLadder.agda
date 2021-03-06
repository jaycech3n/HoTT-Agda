{-# OPTIONS --without-K --rewriting #-}

open import HoTT

module homotopy.TruncationLoopLadder where

  ⊙Ω-Trunc : ∀ {i} {n : ℕ₋₂} (X : Ptd i)
    → ⊙Ω (⊙Trunc (S n) X) ⊙≃ ⊙Trunc n (⊙Ω X)
  ⊙Ω-Trunc X = ≃-to-⊙≃ (=ₜ-equiv [ pt X ] [ pt X ]) idp

  step : ∀ {i j} n {X : Ptd i} {Y : Ptd j} (f : X ⊙→ Y)
    → ⊙CommSquareEquiv
        (⊙Ω-fmap (⊙Trunc-fmap {n = S n} f))
        (⊙Trunc-fmap {n = n} (⊙Ω-fmap f))
        (⊙–> (⊙Ω-Trunc X))
        (⊙–> (⊙Ω-Trunc Y))
  step n (f , idp) =
    ⊙comm-sqr (=ₜ-equiv-nat _ _ _ , idp) , snd (⊙Ω-Trunc _) , snd (⊙Ω-Trunc _)

  rail : ∀ m {i} (X : Ptd i)
    → ⊙Ω^' m (⊙Trunc ⟨ m ⟩ X) ⊙→ ⊙Trunc 0 (⊙Ω^' m X)
  rail O X = ⊙idf _
  rail (S m) X = rail m (⊙Ω X) ⊙∘ ⊙Ω^'-fmap m (⊙–> (⊙Ω-Trunc X))

  ladder : ∀ {i j} m {X : Ptd i} {Y : Ptd j} (f : X ⊙→ Y)
    → ⊙CommSquareEquiv
        (⊙Ω^'-fmap m (⊙Trunc-fmap {n = ⟨ m ⟩} f))
        (⊙Trunc-fmap {n = 0} (⊙Ω^'-fmap m f))
        (rail m X)
        (rail m Y)
  ladder O f = ⊙comm-sqr (⊙∘-unit-l _) , idf-is-equiv _ , idf-is-equiv _
  ladder (S m) f =
    ⊙CommSquareEquiv-∘v (ladder m (⊙Ω-fmap f)) (⊙Ω^'-csemap m (step ⟨ m ⟩ f))
