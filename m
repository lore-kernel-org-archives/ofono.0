Content-Type: multipart/mixed; boundary="===============1428018799296082038=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] added voice call support to ublox plugin
Date: Wed, 08 Aug 2018 20:29:37 +0200
Message-ID: <1533752977-4103-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1428018799296082038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index cfcdd3f..1c46d6f 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -286,6 +286,7 @@ static void ublox_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
+	ofono_voicecall_create(modem, 0, "atmodem", data->app); /* emergency call=
s already possible */
 	sim =3D ofono_sim_create(modem, data->vendor_family, "atmodem",
 					data->aux);
 =

-- =

1.9.1


--===============1428018799296082038==--

