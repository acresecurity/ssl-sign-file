# ssl-sign-file

Sign a file using SSL.com's CodeSignTool

## Inputs

### `filepath`

**Required** File to be signed.

### `sslusername`

**Required** SSL.com account username.

### `sslpassword`

**Required** SSL.com account password.

### `sslsecretpassword`

**Required** SSL.com account TOTP secret.

### `istest`

When true, runs against SSL.com sandbox account.  Default `false`.

## Outputs

## none

## Example usage

        uses: feenicsinc/ssl-sign-file@v1
        with:
          filepath: '../miscellaneous/fake-file.ps1'
          sslusername: 'fake-un'
          sslpassword: 'not-real'
          sslsecretpassword: 'abc123xyz789'
          istest: true
