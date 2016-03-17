Content-Type: multipart/mixed; boundary="===============6575595264372787246=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 4/7] plugins/ublox: support more internet contexts
Date: Thu, 17 Mar 2016 13:38:30 +0100
Message-ID: <1458218313-26966-5-git-send-email-dragos@endocode.com>
In-Reply-To: <1458218313-26966-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6575595264372787246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create multiple gprs-context instances and let the gprs core use
them as it sees fit.

Only for Toby L2.
---
 plugins/ublox.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 544d429..092ba64 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -294,21 +294,25 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	GAtChat *chat =3D data->modem ? data->modem : data->aux;
+	const char *driver =3D data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE ?
+						"ubloxmodem" : "atmodem";
+	/* Toby L2: Create same number of contexts as supported PDP contexts. */
+	int ncontexts =3D data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE ? 8 :=
 1;
 =

 	DBG("%p", modem);
 =

 	gprs =3D ofono_gprs_create(modem, data->vendor_family, "atmodem",
 					data->aux);
-	if (data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE)
-		gc =3D ofono_gprs_context_create(modem, data->vendor_family,
-						"ubloxmodem", chat);
 =

-	else
+	while (ncontexts) {
 		gc =3D ofono_gprs_context_create(modem, data->vendor_family,
-						"atmodem", chat);
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


--===============6575595264372787246==--

