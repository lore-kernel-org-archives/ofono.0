Content-Type: multipart/mixed; boundary="===============2287423102253915770=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [RFC PATCH 1/1] ublox: create only 1 gprs context
Date: Thu, 14 Mar 2019 23:37:26 +0100
Message-ID: <20190314223726.9494-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2287423102253915770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Here's something that I'm having trouble understanding.  The ublox
plugin creates 8 gprs_context atoms.  As far as I can tell, this means
that ofono will allow it to activate 8 contexts simultaneously... right?

Why is the ublox plugin the only one that does this?  Do other modems
not support multiple active contexts?  Or is this plugin wrong?

If I were to follow the model of other plugins, the below patch would
seem appropriate...

A bit of insight here would be appreciated.

Thanks,
Jonas

 plugins/ublox.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index dc001765..3ce60236 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -384,8 +384,6 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs_context *gc;
 	GAtChat *chat =3D data->modem ? data->modem : data->aux;
 	const char *driver;
-	/* Toby L2: Create same number of contexts as supported PDP contexts. */
-	int ncontexts =3D data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE ? 8 :=
 1;
 	int variant;
 =

 	DBG("%p", modem);
@@ -409,14 +407,9 @@ static void ublox_post_sim(struct ofono_modem *modem)
 		variant =3D OFONO_VENDOR_UBLOX;
 	}
 =

-	while (ncontexts) {
-		gc =3D ofono_gprs_context_create(modem, variant, driver, chat);
-
-		if (gprs && gc)
-			ofono_gprs_add_context(gprs, gc);
-
-		--ncontexts;
-	}
+	gc =3D ofono_gprs_context_create(modem, variant, driver, chat);
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
 =

 	ofono_lte_create(modem,
 		ublox_model_to_id(data->model), "ubloxmodem", data->aux);
-- =

2.19.1


--===============2287423102253915770==--

