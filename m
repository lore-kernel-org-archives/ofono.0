Content-Type: multipart/mixed; boundary="===============3857658544007726969=="
MIME-Version: 1.0
From: Jesper Larsen <jesper.larsen@ixonos.com>
Subject: [PATCH v2 3/3] sim900: Use SIM900 quirk for gprs context
Date: Thu, 18 Jul 2013 09:49:58 +0200
Message-ID: <1374133798-20488-3-git-send-email-jesper.larsen@ixonos.com>
In-Reply-To: <1374133798-20488-2-git-send-email-jesper.larsen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3857658544007726969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the module specific quirk for gprs by using the vendor entry
OFONO_VENDOR_SIMCOM_SIM900
---
 plugins/sim900.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/sim900.c b/plugins/sim900.c
index 5d3cd92..a7728cd 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -361,7 +361,7 @@ static void sim900_post_sim(struct ofono_modem *modem)
 	if (gprs =3D=3D NULL)
 		return;
 =

-	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM_SIM900,
 					"atmodem", data->dlcs[GPRS_DLC]);
 	if (gc)
 		ofono_gprs_add_context(gprs, gc);
-- =

1.7.10.4


--===============3857658544007726969==--

