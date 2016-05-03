Content-Type: multipart/mixed; boundary="===============2399642498029380708=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: [PATCH 1/3] Gobi: Enable SIM driver forcing
Date: Tue, 03 May 2016 10:44:53 +0200
Message-ID: <1462265095-3742-1-git-send-email-m.chaplet@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2399642498029380708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let modem detect part overload default SIM driver by using an additional
property named "ForceSimLegacy" (boolean).
---
 plugins/gobi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 061ee04..8850904 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -414,15 +414,21 @@ error:
 static void gobi_pre_sim(struct ofono_modem *modem)
 {
 	struct gobi_data *data =3D ofono_modem_get_data(modem);
+	const char *sim_driver;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "qmimodem", data->device);
 =

 	if (data->features & GOBI_UIM)
-		ofono_sim_create(modem, 0, "qmimodem", data->device);
+		sim_driver =3D "qmimodem";
 	else if (data->features & GOBI_DMS)
-		ofono_sim_create(modem, 0, "qmimodem-legacy", data->device);
+		sim_driver =3D "qmimodem-legacy";
+
+	if (ofono_modem_get_boolean(modem, "ForceSimLegacy"))
+		sim_driver =3D "qmimodem-legacy";
+
+	ofono_sim_create(modem, 0, sim_driver, data->device);
 =

 	if (data->features & GOBI_VOICE)
 		ofono_voicecall_create(modem, 0, "qmimodem", data->device);
-- =

1.9.1


--===============2399642498029380708==--

