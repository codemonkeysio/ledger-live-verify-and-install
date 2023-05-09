# Ledger Live Verify and Install 🔗

These scripts can be used to verify and install [Ledger Live](https://www.ledger.com/ledger-live "Ledger Live") on Linux.

The scripts will allow you to easily verify and install another version of Ledger Live whenever needed.

> Ledger Live as well as the apps you install on it are open source, but the firmware is closed source. If this is a concern for you, then take a look at [Trezor](https://trezor.io/ "Trezor") which is open source or [Coldcard](https://coldcard.com/ "Coldcard") which has viewable, editable, and verifiable source code and only supports Bitcoin.

🐒 Check out the [Code Monkeys Blog!](https://www.codemonkeys.tech/ "Code Monkeys Blog!")

🎥 Subscribe to the [Code Monkeys YouTube Channel!](https://www.youtube.com/channel/UCteut5f1PHW8vP29o66z-kg "Code Monkeys YouTube Channel!")

## Verify the Scripts ✔️

Before running the verification and installation scripts for Ledger Live you should verify the scripts. This will minimize the possibility of the scripts being compromised. To perform the verification you'll need to have `gnupg` and `curl` installed which are most likely already installed on your system, but if not here's how to install them:

### gpg

#### Arch

```sh
sudo pacman -S gnupg
```

#### Debian/Ubuntu

```sh
sudo apt install -y gnupg
```

### curl

#### Arch

```sh
sudo pacman -S curl
```

#### Debian/Ubuntu

```sh
sudo apt install -y curl
```

Now you need to import the public key that signed the manifest file which you can do by running the following command:

```sh
curl https://keybase.io/codemonkeystech/pgp_keys.asc | gpg --import
```

You're now ready to verify the manifest file. You will need to have the `ledger-live-verify-and-install-manifest.sha512sum` and the `ledger-live-verify-and-install-manifest.sha512sum.asc` files which should be in the same directory as the scripts from downloading the repository.

To verify the manifest file run the following command:

```sh
gpg --verify ledger-live-verify-and-install-manifest.sha512sum.asc
```

You should see the following if the verification was successful:

```sh
gpg: assuming signed data in 'ledger-live-verify-and-install-manifest.sha512sum'
gpg: Signature made Tue 09 May 2023 09:40:43 AM EDT
gpg:                using RSA key FCFFD7771CCA9DC3A75EB51AD70C28777CBE04A5
gpg: Good signature from "Jay the Code Monkey <jaythecodemonkey.7vk7i@slmail.me>" [ultimate]
gpg:                 aka "Jay the Code Monkey <c0dem0nkeys@pm.me>" [ultimate]
gpg:                 aka "[jpeg image of size 3958]" [ultimate]
Primary key fingerprint: B7E6 FB94 A589 876C CFC2  1E4B 1E07 E75C 19F1 AE0E
     Subkey fingerprint: FCFF D777 1CCA 9DC3 A75E  B51A D70C 2877 7CBE 04A5
```

> Unless you tell GnuPG to trust the key, you'll see a warning similar to the following:

```sh
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
```

This warning means that the key is not certified by another third party authority. If the downloaded file was a fake, then the signature verification process would fail and you would be warned that the fingerprints don't match.

When you get a warning like this it's also good practice to check the key against other sources, e.g., the [Code Monkeys Keybase](https://keybase.io/codemonkeystech "Code Monkeys Keybase") or the [Code Monkeys Blog](https://codemonkeys.tech/contact/#primary-pgp-key-%F0%9F%94%90 "Code Monkeys Blog").

You have now verified the signature of the manifest file which ensures the integrity and authenticity of the file but not the verification and installation scripts.

To verify the verification and installation scripts you'll need to recompute the SHA512 hashes of the files, compare them with the corresponding hashes in the manifest file, and ensure they match exactly which you can do by running the following command:

```sh
sha512sum --check ledger-live-verify-and-install-manifest.sha512sum
```

If the verification was successful you should see the following output:

```sh
./install-ledger-live.sh: OK
./verify-ledger-live.sh: OK
```

By completing the above steps you will have successfully verified the integrity of the verification and installation scripts, so you can now run the scripts whenever you need to verify and install another version of Ledger Live.

> If for some reason you believe the scripts you have downloaded have been compromised on your machine you can always rerun the above commands again to ensure the integrity of the files.

## Encrypt the Scripts 🔐

To mitigate the possibility of anyone tampering with these scripts you can encrypt the files using, e.g., [GnuPG](https://gnupg.org/ "GnuPG").

### Encrypting the Files

```sh
gpg -c verify-ledger-live.sh
```

```sh
gpg -c install-ledger-live.sh
```

### Decrypting and Extracting the Files

```sh
gpg verify-ledger-live.sh.gpg
```

```sh
gpg install-ledger-live.sh.gpg
```

## Required Programs 💻

The following programs are needed to run the scripts. They're most likely already installed, but if not here's how to install them:

### coreutils

#### Arch

```sh
sudo pacman -S coreutils
```

#### Debian/Ubuntu

```sh
sudo apt install -y coreutils
```

### openssl

#### Arch

```sh
sudo pacman -S openssl
```

#### Debian/Ubuntu

```sh
sudo apt install -y openssl
```

## Tips when Making Online Purchases 🕵️

It's a good idea whenever buying a hardware wallet online (as well as everything else) to use as little Personally Identifiable Information (PII) as possible.

This will mitigate the leaking of PII to the company, any third parties they may be using with their site, hackers, governments, etc.

Here are some tips when shopping online to help you preserve your privacy:

  - You should conceal your IP address when visiting the website or any websites related to the product you're purchasing by using a trusted VPN that you ideally paid for privately, that is open source, claims to not log, etc., e.g., [IVPN](https://www.ivpn.net/ "IVPN") or [Mullvad](https://mullvad.net/en "Mullvad")

  - You also have the option of using [Tor](https://www.torproject.org/ "Tor") to conceal your IP address and if the site offers an onion address you should use it

  - Provide only the minimum amount of information that is required to complete the purchase and don't set up an account unless required

  - Use a pseudonym for your name, an aliased/burner email, an aliased/burner phone number, etc.

  - Don't use your home address or any other address that is easily tied to you for shipping instead use a P.O. box, UPS box, Amazon box, a random address not associated with you, etc.

    - You should set up the mailing solution with as little PII as possible as well

  - Use a private payment method

    - Prepaid cards ideally bought privately, e.g., with cash

    - Use virtual cards using a service like [Privacy](https://privacy.com/ "Privacy") (closed source)

    - Gift cards ideally bought privately, e.g., with cash

    - Money order

    - [Bitcoin](https://bitcoin.org/en/ "Bitcoin") using privacy best practices

    - [Monero](https://www.getmonero.org/ "Monero")

> The above suggestions are not an exhaustive list and do not guarantee you will remain anonymous when purchasing or using the products. There are always trade-offs between privacy, security, convenience, cost, etc., so consider your threat model and come up with a solution that works best for you.

## Tips when Running Ledger Live 🕵️

Here are some tips when using Ledger Live to help you preserve your privacy:

  - Conceal your IP address using a trusted VPN or Tor as described in the above section

  - Use your own node or a node you trust if possible, e.g., when transacting with Bitcoin to prevent leaking your xpub and other PII to Ledger's nodes

  - Set any privacy settings within the application

  - Another option is to use [Sparrow](https://sparrowwallet.com/ "Sparrow") on desktop instead of Ledger Live when transacting with Bitcoin

## Running the Scripts 👨‍💻

To be able to execute the scripts run the following commands:

```sh
chmod u+x verify-ledger-live.sh
```

```sh
chmod u+x install-ledger-live.sh
```

Running 'chmod u+x` on the files grants only the owner of the file execution permissions.

Then verify Ledger Live by running:

```sh
./verify-ledger-live.sh
```

If the verification is successful then install Ledger Live by running:

```sh
./install-ledger-live.sh
```
