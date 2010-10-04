Content-Type: multipart/mixed; boundary="===============5530565951346498126=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [fix-isi-udev PATCH 3/3] ofono.rules: assign isigen driver by USB ids
Date: Mon, 04 Oct 2010 16:11:06 +0300
Message-ID: <1286197866-19572-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286197866-19572-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5530565951346498126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Now using the USB vendor and product IDs like the rest of the oFono
drivers.

For reasons left unclear, the SUBSYSTEMS rule did not work consistently
in Ubuntu 10.04.
---
 plugins/ofono.rules |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 6517757..ccae688 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -342,9 +342,6 @@ SUBSYSTEM!=3D"net", GOTO=3D"ofono_isi_end"
 ATTRS{type}!=3D"820", GOTO=3D"ofono_isi_end"
 KERNELS=3D=3D"gadget", GOTO=3D"ofono_isi_end"
 =

-# Generic / PC Suite mode
-SUBSYSTEMS=3D=3D"usb", ENV{OFONO_DRIVER}=3D"isigen", ENV{OFONO_ISI_ADDRESS=
}=3D"16"
-
 # Nokia N900 modem
 SUBSYSTEMS=3D=3D"hsi", ENV{OFONO_DRIVER}=3D"n900", ENV{OFONO_ISI_ADDRESS}=
=3D"108"
 =

@@ -404,6 +401,9 @@ ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"130=
b", ENV{OFONO_DRIVER}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"130c", ENV{OFONO_DRIVE=
R}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"1311", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

+# Nokia default (with PC Suite)
+ATTRS{idVendor}=3D=3D"0421", ENV{OFONO_DRIVER}=3D"isigen", ENV{OFONO_ISI_A=
DDRESS}=3D"16"
+
 # Nokia Internet Stick CS-10
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"060e", ENV{OFONO_DRIVE=
R}=3D"nokia"
 =

-- =

1.7.0.4


--===============5530565951346498126==--

