Content-Type: multipart/mixed; boundary="===============8794747121360648730=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Subject: oFono Version 1.31 ofonod crash
Date: Sat, 21 Aug 2021 12:08:32 +1000
Message-ID: <CAA=hcWQAWZyiSTQ3r8DiTK2DFuJZZ7hDasAuggfR9shqwz2ioQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8794747121360648730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I build ofono v1.31 from git://git.yoctoproject.org/poky branch hardknott,

$ cat meta/recipes-connectivity/ofono/ofono_1.31.bb

SUMMARY =3D "open source telephony"
DESCRIPTION =3D "oFono is a stack for mobile telephony devices on Linux.
oFono supports speaking to telephony devices through specific drivers,
or with generic AT commands."
HOMEPAGE =3D "http://www.ofono.org"
BUGTRACKER =3D "https://01.org/jira/browse/OF"
LICENSE =3D "GPLv2"
LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Deb723b61539feef013de476e68b5c50a=
 \

file://src/ofono.h;beginline=3D1;endline=3D20;md5=3D3ce17d5978ef3445def265b=
98899c2ee"
DEPENDS =3D "dbus glib-2.0 udev mobile-broadband-provider-info ell"

SRC_URI =3D "\
    ${KERNELORG_MIRROR}/linux/network/${BPN}/${BP}.tar.xz \
    file://ofono \
    file://0001-mbim-add-an-optional-TEMP_FAILURE_RETRY-macro-copy.patch \
"
SRC_URI[md5sum] =3D "1c26340e3c6ed132cc812595081bb3dc"
SRC_URI[sha256sum] =3D
"a15c5d28096c10eb30e47a68b6dc2e7c4a5a99d7f4cfedf0b69624f33d859e9b"

inherit autotools pkgconfig update-rc.d systemd gobject-introspection-data

INITSCRIPT_NAME =3D "ofono"
INITSCRIPT_PARAMS =3D "defaults 22"
SYSTEMD_SERVICE_${PN} =3D "ofono.service"

PACKAGECONFIG ??=3D "\
    ${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'bluez', '', d)} \
"
PACKAGECONFIG[systemd] =3D
"--with-systemdunitdir=3D${systemd_unitdir}/system/,--with-systemdunitdir=
=3D"
PACKAGECONFIG[bluez] =3D "--enable-bluetooth, --disable-bluetooth, bluez5"

EXTRA_OECONF +=3D "--enable-test --enable-external-ell"

do_install_append() {
  install -d ${D}${sysconfdir}/init.d/
  install -m 0755 ${WORKDIR}/ofono ${D}${sysconfdir}/init.d/ofono
}

PACKAGES =3D+ "${PN}-tests"

FILES_${PN} +=3D "${systemd_unitdir}"
FILES_${PN}-tests =3D "${libdir}/${BPN}/test"

RDEPENDS_${PN} +=3D "dbus"
RDEPENDS_${PN}-tests =3D "\
    python3-core \
    python3-dbus \
    ${@bb.utils.contains('GI_DATA_ENABLED', 'True',
'python3-pygobject', '', d)} \
"

RRECOMMENDS_${PN} +=3D "kernel-module-tun mobile-broadband-provider-info"

The build was fine, but running the v1.31 ofono.service crashed at
udevng.c missing OFONO_DRIVER property, the ofono.service was repeated
to be restarted every 6 seconds:

.....

ofonod[9005]: ../ofono-1.31/plugins/udevng.c:add_serial_device()
Device is missing required OFONO_DRIVER property
ofonod[9005]: ../ofono-1.31/plugins/udevng.c:add_serial_device()
Device is missing required OFONO_DRIVER property
......

I am not quite sure if it is ofono 1.31 problem or oe-core
ofono_1.31.bb problem, could anyone have a look at and advise? Let me
know if you need more debug information.

Thank you.

Kind regards,

- jupiter


On 8/20/21, Jupiter <jupiter.hce@gmail.com> wrote:
> Hi,
>
> I upgraded from Zeus to Hardknotte, I was able to run dbus to get
> interface properties, but I failed on Hardknotte ofono 1.31. Has
> anyone got oFono 1.31 dbus work?
>
> Thank you.
>
> Kind regards,
>
> - jupiter
>
--===============8794747121360648730==--

