# Decentralized Digital Identity Corporate Access Management

This project implements a decentralized digital identity system for corporate access management using Clarity smart contracts. The system provides secure identity verification, credential issuance, access control, authentication, and audit logging.

## Smart Contracts

### 1. Identity Administrator Verification (`identity-admin.clar`)

This contract manages identity administrators who have the authority to issue credentials and manage access.

- **Functions**:
    - `is-admin`: Check if a principal is an administrator
    - `add-admin`: Add a new administrator (only callable by existing admins)
    - `remove-admin`: Remove an administrator (only callable by existing admins)
    - `initialize`: Set up the contract with the deployer as the first admin

### 2. Credential Issuance (`credential-issuance.clar`)

This contract handles the issuance and management of digital identity credentials.

- **Functions**:
    - `issue-credential`: Issue a new credential to a user
    - `revoke-credential`: Revoke a previously issued credential
    - `is-credential-valid`: Check if a credential is valid (not expired or revoked)
    - `get-credential`: Retrieve credential details

### 3. Access Control (`access-control.clar`)

This contract manages access to corporate resources based on credentials and roles.

- **Functions**:
    - `grant-resource-access`: Allow a credential type to access a resource
    - `revoke-resource-access`: Remove access for a credential type
    - `assign-role`: Assign a role to a user
    - `user-can-access`: Check if a user can access a specific resource
    - `has-role`: Check if a user has a specific role

### 4. Authentication Protocol (`authentication.clar`)

This contract handles the authentication of identity credentials.

- **Functions**:
    - `create-challenge`: Generate a new authentication challenge
    - `verify-credential`: Verify a credential against a challenge
    - `is-challenge-completed`: Check if a challenge has been completed

### 5. Audit Logging (`audit-logging.clar`)

This contract logs all identity and access-related activities for audit purposes.

- **Functions**:
    - `log-event`: Record an access event
    - `log-event-with-details`: Record an event with additional details
    - `get-log`: Retrieve a specific log entry
    - `has-event-logs`: Check if a user has logs of a specific event type

## Getting Started

1. Deploy the contracts in the following order:
    - `identity-admin.clar`
    - `credential-issuance.clar`
    - `access-control.clar`
    - `authentication.clar`
    - `audit-logging.clar`

2. Initialize the identity-admin contract to set up the first administrator:
   \`\`\`
   (contract-call? .identity-admin initialize)
   \`\`\`

3. Use the administrator account to issue credentials and set up access controls.

## Security Considerations

- The system uses a role-based access control model
- All administrative actions require authentication as an admin
- Credentials can be revoked if compromised
- All access events are logged for audit purposes
- Multiple administrators can be added for redundancy

## Testing

Tests are written using Vitest and can be found in the `tests` directory.
