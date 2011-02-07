Content-Type: multipart/mixed; boundary="===============0825571098801909340=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: [PATCH 3/3] udev: Add Teracom (Linktop/LW27x) device detection
Date: Mon, 07 Feb 2011 08:52:04 +0530
Message-ID: <1297048924-11919-3-git-send-email-mendapara.amit@gmail.com>
In-Reply-To: <1297048924-11919-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0825571098801909340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 111f071..f01b739 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -451,4 +451,7 @@ ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"062=
3", ENV{OFONO_DRIVER}=3D"nokia"
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"023e", ENV{OFONO_DRIVE=
R}=3D"nokiacdma"
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b6", ENV{OFONO_DRIVE=
R}=3D"nokiacdma"
 =

++# Teracom (Linktop/LW27x) 3G Data Card
++ATTRS{idVendor}=3D=3D"230d", ATTRS{idProduct}=3D=3D"0001", ENV{OFONO_DRIV=
ER}=3D"linktop"
+
 LABEL=3D"ofono_end"
-- =

1.7.1


--===============0825571098801909340==--

