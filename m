Content-Type: multipart/mixed; boundary="===============2449631280613625446=="
MIME-Version: 1.0
From: F. Gau <fgau@pyneo.org>
Subject: [PATCH 1/2] set huawei em770 modem device to 01 to free up 00
Date: Fri, 10 Dec 2010 19:25:17 +0100
Message-ID: <1292005517-19049-1-git-send-email-fgau@pyneo.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2449631280613625446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: M. Dietrich <mdt@emdete.de>

	device 00 is ppp capable while 01 is not. 01 does everything
	else fine so ofono works with it flawlessly.
---
 plugins/ofono.rules |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index da8a8ef..9369566 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -30,7 +30,7 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1401"=
, ENV{OFONO_IFACE_NUM}=3D=3D"02", E
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 =

-ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_HUAWE=
I_VOICE}=3D"1"
 =

-- =

1.7.2.3



--===============2449631280613625446==--

