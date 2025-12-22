{... }:

{
  # https://github.com/cubewhy/open-ganss-gs-3104t-pro
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  services.udev.extraHwdb = ''
    evdev:input:*
     KEYBOARD_KEY_7009c=unknown
     KEYBOARD_KEY_700e8=unknown
  '';
}
