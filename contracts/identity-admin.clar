;; Identity Administrator Verification Contract
;; This contract validates and manages identity administrators

(define-data-var admin-count uint u0)

(define-map administrators principal bool)

;; Check if a principal is an administrator
(define-read-only (is-admin (admin principal))
  (default-to false (map-get? administrators admin))
)

;; Add a new administrator (only existing admins can add)
(define-public (add-admin (new-admin principal))
  (begin
    (asserts! (is-admin tx-sender) (err u403))
    (asserts! (not (is-admin new-admin)) (err u409))
    (map-set administrators new-admin true)
    (var-set admin-count (+ (var-get admin-count) u1))
    (ok true)
  )
)

;; Remove an administrator (only existing admins can remove)
(define-public (remove-admin (admin-to-remove principal))
  (begin
    (asserts! (is-admin tx-sender) (err u403))
    (asserts! (is-admin admin-to-remove) (err u404))
    (asserts! (> (var-get admin-count) u1) (err u400))
    (map-delete administrators admin-to-remove)
    (var-set admin-count (- (var-get admin-count) u1))
    (ok true)
  )
)

;; Initialize the contract with the deployer as the first admin
(define-public (initialize)
  (begin
    (asserts! (is-eq (var-get admin-count) u0) (err u409))
    (map-set administrators tx-sender true)
    (var-set admin-count u1)
    (ok true)
  )
)
