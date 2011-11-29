Content-Type: multipart/mixed; boundary="===============3958729857331326589=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 5/5] udev: Add rules to support SpeedUp 9800 dongle
Date: Tue, 29 Nov 2011 13:21:21 +0100
Message-ID: <1322569281-10908-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1322569281-10908-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3958729857331326589==
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


--===============3958729857331326589==--

