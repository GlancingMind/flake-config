{ pkgs, ... }:
{
  programs.surfraw = {
    enable = true;

    #TODO linked elvis are not executable!

    addBookmark.file = ./tbookmark;
    #addBookmark.toStore = true;
    #addBookmark.file = "${pkgs.surfraw}/etc/xdg/surfraw/bookmarks";

    addElviToPath = true;

    #addElvi = ./elvis;
    #addElvi = ./testelvi;
    #addElvi = [ ./elvis ./testelvi ];
    #addElvi = [ ./elvis ./testelvi
    #(pkgs.buildPackages.writeScript "wSB-elvi" "#Hello, this is a test!")];
    #addElvi = pkgs.buildPackages.writeScript "wSB-elvi" "#Hello, this is a test!";
    #addElvi = pkgs.buildPackages.writeScriptBin "wSB-elvi" "#Hello, this is a test!";
    #addElvi = [ (pkgs.buildPackages.writeScriptBin "wSB-elvi" "#Hello, this is a test!") ];

    config.useGraphicalBrowser = false;
    config.textual.browser = "${pkgs.w3m}/bin/w3m";
    config.textual.browserArgs = ["-cols 2" "-dump"];

    settings = {
      #graphical = false;
      #graphical_browser_args = "";
      #quote_args = true;
      #text_browser = "${pkgs.w3m}/bin/w3m";
      #text_browser = "w3m";
      #text_browser_args = "-dump -M";
    };
  };
}
