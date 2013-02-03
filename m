Content-Type: multipart/mixed; boundary="===============2799451876732108876=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: [PATCH 0/4] improving QMI support on recent kernels
Date: Sun, 03 Feb 2013 22:39:43 +0100
Message-ID: <1359927587-24353-1-git-send-email-bjorn@mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2799451876732108876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I saw this report regarding problems with ofono on newer kernels a while ag=
o:
http://www.spinics.net/lists/netdev/msg222072.html
and finally got around to looking a bit closer at the problem.  Or problems.
There appear to be several minor issues:

1) udev doesn't run the internal usb_id command on "usbmisc" devices

At least it doesn't on my Debian system, using udev 175.  The result is
that the /dev/cdc-wdmX devices don't have any ID_USB_INTERFACE_NUM or
ID_BUS properties, so they are not picked up at all by udevng

This should probably be fixed more generic in udev, but I haven't got
the faintest clue how to do that.  A simple workaround is installing
a udev rule like this:

ACTION=3D=3D"remove", GOTO=3D"usbmisc_end"
SUBSYSTEM!=3D"usbmisc", GOTO=3D"usbmisc_end"

SUBSYSTEMS=3D=3D"usb", ENV{ID_MODEL}=3D=3D"", IMPORT{builtin}=3D"usb_id"
SUBSYSTEMS=3D=3D"usb", ENV{ID_MODEL_FROM_DATABASE}=3D=3D"", IMPORT{program}=
=3D"usb-db %p"
SUBSYSTEMS=3D=3D"usb", ATTRS{idVendor}!=3D"", ATTRS{idProduct}!=3D"", ENV{I=
D_VENDOR_ID}=3D"$attr{idVendor}", ENV{ID_MODEL_ID}=3D"$attr{idProduct}"

LABEL=3D"usbmisc_end"


2) udevng doesn't listen for "usbmisc"

The "usb" class was recently renamed:

 commit 7e97243c2080ecae7129e83635227fdebd4feef6
 Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 Date:   Wed Apr 25 17:22:37 2012 -0700

    USB: rename the usb misc class from "usb" to "usbmisc"
    =

    This class was not named properly years ago, and it turns out that tools
    like udev can't properly see the devices in this class after booting due
    to the fact that there is a bus with the same name in the system.
    =

    Changing this to "usbmisc" fixes this problem, and it solves the problem
    for the future when we want to unify classes and busses.
    =

    Reported-by: Kay Sievers <kay@vrfy.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


This is fixed by the first patch in this series. =



3) setup_huawei made some broken assumptions about device and USB interface
   relationship

The Huawei devices can split the QMI/wwan function in a CDC like control+da=
ta
fashion.  The early drivers attached the cdc-wdmX QMI device to the control
interface and the wwanY device to the data interface.  This was later chang=
ed
and both devices are now attached to the control interface.

Patch #2 makes the device subsystem available for the setup_* functions
and patch #3 uses this to support "qmi" and "net" sharing the same USB
interface as parent.

And while testing if this approach would work for devices sharing a single
USB interface for QMI and wwan I added QMI support for Sierra Wireless
devices.  This was tested on a MC7710 in QMI mode.

But when I say "tested", I mean that I barely fired up ofonod and saw that
the different functions were found and assigned to the correct variables. I
have not actually tested that any of this is working. =




Bj=C3=B8rn Mork (4):
  udevng: the "usb" class has been renamed to "usbmisc"
  udevng: make subsystem available for modem setup
  udevng: support Huawei QMI modems on newer kernels
  udevng: support Sierra QMI devices

 plugins/udevng.c |   32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

-- =

1.7.10.4


--===============2799451876732108876==--

