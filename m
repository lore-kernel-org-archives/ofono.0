Content-Type: multipart/mixed; boundary="===============8330646389859608079=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] udev: do not use weird serial with zte
Date: Mon, 08 Nov 2010 20:41:24 +0200
Message-ID: <1289241684-25197-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8330646389859608079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/ofono.rules |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index f2a8162..da8a8ef 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -363,6 +363,8 @@ ATTRS{idVendor}=3D=3D"12d1", ENV{OFONO_DRIVER}=3D"huawe=
i"
 # ZTE Incorporated
 ATTRS{idVendor}=3D=3D"19d2", ENV{OFONO_DRIVER}=3D"zte"
 =

+ATTRS{idVendor}=3D=3D"19d2", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
+
 # Option Globetrotter
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"6911", ENV{OFONO_DRIVE=
R}=3D"hso"
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"6971", ENV{OFONO_DRIVE=
R}=3D"hso"
-- =

1.7.1


--===============8330646389859608079==--

