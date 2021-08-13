
;; timelock

;; roughly 52560 blocks per year

;; roughly next year
(define-constant unlock-height (+ block-height u52560))
(define-constant beneficiary 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK)

(define-read-only (get-unlock-height)
    unlock-height
)

(define-public (redeem (recipient principal))
    (begin
        (asserts! (is-eq tx-sender beneficiary) (err u100)) ;;not the beneficiary
        (asserts! (>= block-height unlock-height) (err u101)) ;;block-height not reached
        (as-contract (stx-transfer? (stx-get-balance tx-sender) tx-sender recipient))  ;; amount sender recipient
    )
)