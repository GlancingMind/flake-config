{ pkgs, ...}:
{
  # Increase file watches for nodejs etc. as the default is not enough
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 48576;
  };
}
