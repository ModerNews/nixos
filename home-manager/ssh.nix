{...}: {
  # SCAFFOLD — the real ~/.ssh/config was not retrieved off the old machine.
  #
  # The audit records only that two hosts exist, "linode" and "proxy", with
  # non-default ports, users and identity files. The actual values are not in
  # the audit and cannot be inferred, so they are FIXMEs rather than guesses —
  # a wrong Port or User fails in a way that looks like a network problem.
  #
  # ~/.ssh is on the backup list. Fill these from the real file, then delete it
  # rather than restoring it: the point of this module is that the config stops
  # being a hand-edited file.
  #
  # NOTE: the audit specifies `programs.ssh.matchBlocks`, which is DEPRECATED in
  # Home Manager 26.05 — it warns and tells you to use `programs.ssh.settings`.
  # The new form is a DAG keyed by the literal Host block name, with plain
  # ssh_config directive names (CamelCase) rather than the old lowercase
  # Home Manager option names.
  programs.ssh = {
    enable = true;

    # The old implicit defaults are being removed upstream. Pinning them here
    # explicitly keeps behaviour identical instead of inheriting whatever the
    # default becomes later.
    enableDefaultConfig = false;

    settings = {
      "*" = {
        ForwardAgent = false;
        AddKeysToAgent = "no";
        Compression = false;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ControlMaster = "no";
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
      };

      linode = {
        # HostName = "FIXME";
        # User = "FIXME";
        # Port = 22;                    # audit: non-default
        # IdentityFile = "~/.ssh/FIXME";
        IdentitiesOnly = true;
      };

      proxy = {
        # HostName = "FIXME";
        # User = "FIXME";
        # Port = 22;                    # audit: non-default
        # IdentityFile = "~/.ssh/FIXME";
        IdentitiesOnly = true;
      };
    };
  };
}
