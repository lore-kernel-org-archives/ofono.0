Content-Type: multipart/mixed; boundary="===============9024943352014429463=="
MIME-Version: 1.0
From: Hannu Lyytinen <hannu.lyytinen@nomovok.com>
Subject: [PATCH 2/2] Added Nokia CS-17 to udev rules.
Date: Sat, 06 Nov 2010 21:48:48 +0200
Message-ID: <1289072928-11812-2-git-send-email-hannu.lyytinen@nomovok.com>
In-Reply-To: <1289072928-11812-1-git-send-email-hannu.lyytinen@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9024943352014429463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The stick has to be initialized with usb_modeswitch, though.
---
 plugins/ofono.rules |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index f46d198..859da56 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -424,4 +424,7 @@ ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"131=
1", ENV{OFONO_DRIVER}=3D"mbm"
 # Nokia Internet Stick CS-10
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"060e", ENV{OFONO_DRIVE=
R}=3D"nokia"
 =

+# Nokia Internet Stick CS-17
+ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"0623", ENV{OFONO_DRIVE=
R}=3D"nokia"
+
 LABEL=3D"ofono_end"
-- =

1.7.0.4


--===============9024943352014429463==--

