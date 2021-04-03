{ pkgs, ...}:
{
  fonts.enableDefaultFonts = true;

  # Select internationalisation properties.
  console.font = "Lat2-Terminus16";
  console.keyMap = "de";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
}
