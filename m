Content-Type: multipart/mixed; boundary="===============8588241961656009348=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/5] udev: Add rules to support ZTE MF190 dongle
Date: Tue, 29 Nov 2011 13:21:18 +0100
Message-ID: <1322569281-10908-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1322569281-10908-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8588241961656009348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index c7fac57..079db07 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -22,6 +22,9 @@ KERNEL!=3D"ttyUSB[0-9]*", GOTO=3D"ofono_tty_end"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"02", ENV{OFONO_LABEL}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
 =

+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"04", ENV{OFONO_LABEL}=3D"modem"
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
+
 LABEL=3D"ofono_tty_end"
 =

 SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"
-- =

1.7.1


--===============8588241961656009348==--

