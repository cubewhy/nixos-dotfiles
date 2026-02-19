{pkgs, ...}: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib
    zstd
    stdenv.cc.cc
    stdenv.cc.cc.lib
    curl
    openssl
    attr
    libssh
    bzip2
    libxml2
    acl
    libsodium
    util-linux
    xz
    systemd

    libXcomposite
    libXtst
    libXrandr
    libXext
    libX11
    libXfixes
    libGL
    libva
    pipewire
    libxcb
    libXdamage
    libxshmfence
    libXxf86vm
    libglvnd
    libelf
    libepoxy

    glfw
    glfw3-minecraft

    glib
    gtk2

    networkmanager
    vulkan-loader
    libgbm
    libdrm
    libxcrypt
    coreutils
    pciutils
    zenity

    libXinerama
    libXcursor
    libXrender
    libXScrnSaver
    libXi
    libSM
    libICE
    gnome2.GConf
    nspr
    nss
    cups
    libcap
    SDL2
    libusb1
    dbus-glib
    ffmpeg
    libudev0-shim

    gtk3
    icu
    libnotify
    gsettings-desktop-schemas

    libXt
    libXmu
    libogg
    libvorbis
    SDL
    SDL2_image
    glew
    libidn
    tbb

    flac
    freeglut
    libjpeg
    libpng
    libpng12
    libsamplerate
    libmikmod
    libtheora
    libtiff
    pixman
    speex
    SDL_image
    SDL_ttf
    SDL_mixer
    SDL2_ttf
    SDL2_mixer
    libappindicator-gtk2
    libdbusmenu-gtk2
    libindicator-gtk2
    libcaca
    libcanberra
    libgcrypt
    libvpx
    librsvg
    libXft
    libvdpau
    pango
    cairo
    atk
    gdk-pixbuf
    fontconfig
    freetype
    dbus
    alsa-lib
    expat
    libxkbcommon
    wayland

    libxcrypt-legacy
    libGLU

    fuse
    e2fsprogs

    # (pkgs.runCommand "steamrun-lib" {} "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
  ];
}
