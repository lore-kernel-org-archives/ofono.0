Content-Type: multipart/mixed; boundary="===============1314152199295084746=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Beno=C3=AEt?= Monin <benoit.monin@gmx.fr>
Subject: [PATCH] hso: Set modem name based on udev network interface name
Date: Thu, 21 Oct 2010 10:26:20 +0200
Message-ID: <20101021082620.178830@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1314152199295084746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Useful if you have multiple identical modems and you need a way
to know which modem you're talking to.
---
 plugins/udev.c | =C2=A0 =C2=A01 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 737a637..e687c01 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -191,6 +191,7 @@ static void add_hso(struct ofono_modem *modem,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (g_str_equal(subsystem, "net") =3D=3D=
 TRUE) {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devnode =3D get_pro=
perty(udev_device, "INTERFACE");
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_modem_set_str=
ing(modem, NETWORK_INTERFACE, devnode);
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_modem_set_name(mod=
em, devnode);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
--

--===============1314152199295084746==--

