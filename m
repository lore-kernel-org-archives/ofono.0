Content-Type: multipart/mixed; boundary="===============5783826115688633902=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] udev: add support for Vodaphone K3570-Z modem
Date: Fri, 29 Jul 2011 14:59:31 +0200
Message-ID: <1311944371-4337-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5783826115688633902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index b7eb73c..bcfd56d 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -35,6 +35,9 @@ ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0121"=
, ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"04", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"02", ENV{OFONO_ZTE_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
+
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"2003", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"2003", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

-- =

1.7.4.1

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

--===============5783826115688633902==--

