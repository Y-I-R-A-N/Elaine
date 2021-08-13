
;; elaine-token


(impl-trait .nft-trait.nft-trait)

(define-non-fungible-token elaine-token uint)
(define-data-var last-token-id uint u0)


(define-constant contract-owner tx-sender)

(define-public (mint)
	(let
		(
			(token-id (+ (var-get last-token-id) u1))
		)
		;; Check that the tx-sender is equal to the contract-owner.
		(asserts! (is-eq contract-owner tx-sender) (err u100))
		(var-set last-token-id token-id)
		(nft-mint? elaine-token token-id tx-sender)
	)
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
	(begin
		;; Check that the tx-sender and sender are equal.
		;; The error we emit (err u101) has no special meaning.
		(asserts! (is-eq tx-sender sender) (err u101))
		(nft-transfer? elaine-token token-id sender recipient)
	)
)

(define-public (get-last-token-id)
    (ok (var-get last-token-id))
)

(define-read-only (get-owner (token-id uint))
    (ok (nft-get-owner? elaine-token token-id))
)

(define-read-only (get-token-uri (token-id uint))
    (ok none)
)
