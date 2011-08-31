Content-Type: multipart/mixed; boundary="===============2619183381066158407=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 5/5] udev: Add rules to support SpeedUp 9800 dongle
Date: Wed, 31 Aug 2011 11:26:35 +0200
Message-ID: <1314782795-9816-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1314782795-9816-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2619183381066158407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 7f284d4..9e7a651 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -29,6 +29,10 @@ ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124=
", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"00", ENV{OFONO_LABEL}=3D"modem"
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_LABEL}=3D"aux"
 =

+# SpeedUp 9800
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"modem"
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"02", ENV{OFONO_LABEL}=3D"aux"
+
 LABEL=3D"ofono_tty_end"
 =

 SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"
-- =

1.7.1


--===============2619183381066158407==--

