{
  services.dunst = {
    enable = true;
    waylandDisplay = "0";

    settings = {
      global = {
        monitor = 0;
        follow = "none";
      };

      urgency_low = {
        timeout = 3;
      };

      urgency_normal = {
        timeout = 5;
      };

      urgency_critical = {
      };
    };
  };
}
