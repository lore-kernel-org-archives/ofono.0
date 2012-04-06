Content-Type: multipart/mixed; boundary="===============0774244933596108362=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Add udev rules for SpeedUp U3501
Date: Fri, 06 Apr 2012 15:30:32 +0200
Message-ID: <1333719032-7719-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0774244933596108362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono-speedup.rules |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono-speedup.rules b/plugins/ofono-speedup.rules
index f43fc7b..acf8857 100644
--- a/plugins/ofono-speedup.rules
+++ b/plugins/ofono-speedup.rules
@@ -20,4 +20,8 @@ ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008"=
, ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"modem"
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"02", ENV{OFONO_LABEL}=3D"aux"
 =

+# SpeedUp U3501
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9605", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_LABEL}=3D"modem"
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9605", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
+
 LABEL=3D"ofono_speedup_end"
-- =

1.7.5.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============0774244933596108362==--

