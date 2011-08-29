Content-Type: multipart/mixed; boundary="===============7245881699350568227=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 4/5] udev: Add rules to support Speedup 7300 dongle
Date: Mon, 29 Aug 2011 18:41:50 +0200
Message-ID: <1314636111-16146-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1314636111-16146-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7245881699350568227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 079db07..7f284d4 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -25,6 +25,10 @@ ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017=
", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"04", ENV{OFONO_LABEL}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
 =

+# SpeedUp 7300
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"00", ENV{OFONO_LABEL}=3D"modem"
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_LABEL}=3D"aux"
+
 LABEL=3D"ofono_tty_end"
 =

 SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"
-- =

1.7.1


--===============7245881699350568227==--

