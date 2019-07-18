Content-Type: multipart/mixed; boundary="===============0933919259399702898=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 07/10] ublox: create only 1 gprs context
Date: Thu, 18 Jul 2019 12:23:11 +0200
Message-ID: <20190718102314.28094-7-jonas@norrbonn.se>
In-Reply-To: <20190718102314.28094-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0933919259399702898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some uBlox modems support multiple, simultaneously active contexts.  These
contexts are either bridged to the network interface or handled
transparently by the modem acting like a router.

The problem with this approach is that ofono and ofono clients (e.g.
mmsd) expect a dedicated _local_ network interface for each context.

As such, it doesn't make sense for ofono to set up the multiple gprs
contexts.
---
 plugins/ublox.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index c6ff7eaa..1da7101e 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -357,8 +357,6 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs_context *gc;
 	GAtChat *chat =3D data->modem ? data->modem : data->aux;
 	const char *driver;
-	/* Toby L2: Create same number of contexts as supported PDP contexts. */
-	int ncontexts =3D data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE ? 8 :=
 1;
 	const char *iface;
 	int variant;
 =

@@ -376,14 +374,9 @@ static void ublox_post_sim(struct ofono_modem *modem)
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

2.20.1


--===============0933919259399702898==--

