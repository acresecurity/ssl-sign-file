# ssl-sign-file
Sign a file using SSL.com's CodeSignTool

## Inputs

### `file-path`

**Required** File to be signed.

### `ssl-username`

**Required** SSL.com account username.

### `ssl-password`

**Required** SSL.com account password.

### `ssl-secret-password`

**Required** SSL.com account TOTP secret.

### `is-test`

When true, runs against SSL.com sandbox account.  Default `false`.

## Outputs

## none

## Example usage

        uses: feenicsinc/ssl-sign-file@v1
        with:
          file-path: '../miscellaneous/fake-file.ps1'
          ssl-username: 'fake-un'
          ssl-password: 'not-real'
          ssl-secret-password: 'abc123xyz789'
          is-test: true
