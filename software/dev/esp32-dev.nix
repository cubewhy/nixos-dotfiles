{...}: {
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb-serial", TAG+="uaccess"
  '';
}
