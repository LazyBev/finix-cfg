{pkgs, ...}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
      KexAlgorithms = [
        "mlkem768x25519-sha256"
        "sntrup761x25519-sha512"
        "sntrup761x25519-sha512@openssh.com"
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group-exchange-sha256"
        "diffie-hellman-group14-sha256"
        "diffie-hellman-group14-sha1"
        "diffie-hellman-group-exchange-sha1"
        "ecdh-sha2-nistp256"
        "ecdh-sha2-nistp384"
        "ecdh-sha2-nistp521"
      ];
      Ciphers = [
        "chacha20-poly1305@openssh.com"
        "aes256-gcm@openssh.com"
        "aes128-gcm@openssh.com"
        "aes256-ctr"
        "aes192-ctr"
        "aes128-ctr"
        "aes256-cbc"
        "aes128-cbc"
      ];
      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
        "hmac-sha2-512"
        "hmac-sha2-256"
      ];
      HostKeyAlgorithms = [
        "ssh-ed25519"
        "ssh-rsa"
        "rsa-sha2-512"
        "rsa-sha2-256"
      ];
      PubkeyAcceptedAlgorithms = [
        "ssh-ed25519"
        "ssh-rsa"
        "rsa-sha2-512"
        "rsa-sha2-256"
      ];
    };
  };
}
