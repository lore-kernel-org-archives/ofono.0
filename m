Content-Type: multipart/mixed; boundary="===============8472806887148667808=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 2/2] quectel: pass vendor id to gprs and gprs-context
Date: Fri, 19 Jul 2019 12:27:46 +0200
Message-ID: <20190719102746.122911-2-martin@geanix.com>
In-Reply-To: <20190719102746.122911-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8472806887148667808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The gprs-context does special casing on the quectel serial modem when
probing the supported layer 2 protocols, so pass the vendor id when
setting up the atoms.
---
 plugins/quectel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 9cac92fa..667a7c7c 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -717,8 +717,9 @@ static void quectel_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->aux);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+	gprs =3D ofono_gprs_create(modem, data->vendor, "atmodem", data->aux);
+	gc =3D ofono_gprs_context_create(modem, data->vendor, "atmodem",
+					data->modem);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
-- =

2.22.0


--===============8472806887148667808==--

