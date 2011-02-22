Content-Type: multipart/mixed; boundary="===============7972668695040673952=="
MIME-Version: 1.0
From: Rolf Offermanns <roffermanns@sysgo.com>
Subject: [PATCH] ofono.rules - remove patch leftovers in linktop rule
Date: Tue, 22 Feb 2011 14:36:38 +0100
Message-ID: <20110222133637.GA12115@sysgo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7972668695040673952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Trivial fix for rules file.

---
 plugins/ofono.rules |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 121825e..a327923 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -452,7 +452,7 @@ ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"062=
3", ENV{OFONO_DRIVER}=3D"nokia"
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"023e", ENV{OFONO_DRIVE=
R}=3D"nokiacdma"
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b6", ENV{OFONO_DRIVE=
R}=3D"nokiacdma"
 =

-+# Teracom (Linktop/LW27x) 3G Data Card
-+ATTRS{idVendor}=3D=3D"230d", ATTRS{idProduct}=3D=3D"0001", ENV{OFONO_DRIV=
ER}=3D"linktop"
+# Teracom (Linktop/LW27x) 3G Data Card
+ATTRS{idVendor}=3D=3D"230d", ATTRS{idProduct}=3D=3D"0001", ENV{OFONO_DRIVE=
R}=3D"linktop"
 =

 LABEL=3D"ofono_end"
-- =

1.7.4


--===============7972668695040673952==--

