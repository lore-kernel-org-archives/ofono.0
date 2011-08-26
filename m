Content-Type: multipart/mixed; boundary="===============7935725305573478971=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 4/4] udev: Add rules to support ZTE MF190 dongle
Date: Fri, 26 Aug 2011 17:21:53 +0200
Message-ID: <1314372113-29410-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1314372113-29410-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7935725305573478971==
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


--===============7935725305573478971==--

