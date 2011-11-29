Content-Type: multipart/mixed; boundary="===============8518737467227449854=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/5] udev: Add rules to support ZTE MF668 dongle
Date: Tue, 29 Nov 2011 13:21:17 +0100
Message-ID: <1322569281-10908-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1322569281-10908-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8518737467227449854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 30a1b7e..c7fac57 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -15,6 +15,15 @@ KERNEL=3D=3D"shrm0", ENV{OFONO_DRIVER}=3D"u8500"
 =

 LABEL=3D"ofono_isi_end"
 =

+SUBSYSTEM!=3D"tty", GOTO=3D"ofono_tty_end"
+KERNEL!=3D"ttyUSB[0-9]*", GOTO=3D"ofono_tty_end"
+
+# ZTE
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"02", ENV{OFONO_LABEL}=3D"modem"
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
+
+LABEL=3D"ofono_tty_end"
+
 SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"
 ENV{DEVTYPE}!=3D"usb_device", GOTO=3D"ofono_end"
 =

-- =

1.7.1


--===============8518737467227449854==--

