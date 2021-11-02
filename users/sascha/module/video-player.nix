{ pkgs, config, ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      #NOTE use the more frequently updated yt-dlp instead of youtube-dl to
      # circumvent throtteling issues.
      script-opts="ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp";
    };
    profiles = {
      "youtube-1080p" = {
        ytdl-format="bestvideo[height<=?1080]+bestaudio/best";
      };
      "youtube-720p" = {
        ytdl-format="bestvideo[height<=?720]+bestaudio/best";
      };
      "youtube-480p" = {
        ytdl-format="bestvideo[height<=?480]+bestaudio/best";
      };
      "youtube-360p" = {
        ytdl-format="bestvideo[height<=?360]+bestaudio/best";
      };
    };
  };
}
