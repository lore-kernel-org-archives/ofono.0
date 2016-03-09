Content-Type: multipart/mixed; boundary="===============2101692538643659724=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 16/19] plugins/ublox: support more internet contexts
Date: Wed, 09 Mar 2016 16:44:57 +0100
Message-ID: <1457538300-7183-17-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2101692538643659724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create multiple gprs-context instances and let the gprs core use
them as it sees fit.

Only for Toby L2.
---
 plugins/ublox.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 032a3c4..76f7fcf 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -295,23 +295,26 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	struct ublox_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	GAtChat *chat =3D data->modem ? data->modem : data->aux;
+	const char *driver =3D data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE ?
+							"ubloxmodem":"atmodem";
+	/* Toby L2: Create same number of contexts as supported PDP contexts. */
+	int ncontexts =3D data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE ? 8:1;
 =

 	DBG("%p", modem);
 =

 	gprs =3D ofono_gprs_create(modem, data->vendor_family, "atmodem",
 					data->aux);
-	if (data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE)
-		gc =3D ofono_gprs_context_create(modem, data->vendor_family,
-						"ubloxmodem",
-						data->modem ? data->modem : data->aux);
 =

-	else
+	while (ncontexts) {
 		gc =3D ofono_gprs_context_create(modem, data->vendor_family,
-						"atmodem",
-						data->modem ? data->modem : data->aux);
+						driver, chat);
 =

-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
+		if (gprs && gc)
+			ofono_gprs_add_context(gprs, gc);
+
+		--ncontexts;
+	}
 }
 =

 static void ublox_post_online(struct ofono_modem *modem)
-- =

2.5.0


--===============2101692538643659724==--

