Content-Type: multipart/mixed; boundary="===============2309317724283911531=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] mbmmodem: do not check for NULL pointer
Date: Fri, 04 Mar 2011 10:10:14 -0300
Message-ID: <1299244214-12411-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1299244214-12411-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2309317724283911531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

cb_data_new() uses g_new0(), hence there's no need to check the return
value being NULL.
---
 drivers/mbmmodem/location-reporting.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/locat=
ion-reporting.c
index b76a5c2..1080e62 100644
--- a/drivers/mbmmodem/location-reporting.c
+++ b/drivers/mbmmodem/location-reporting.c
@@ -166,16 +166,12 @@ static void mbm_location_reporting_enable(struct ofon=
o_location_reporting *lr,
 =

 	DBG("lr=3D%p", lr);
 =

-	if (cbd =3D=3D NULL)
-		goto out;
-
 	cbd->user =3D lr;
 =

 	if (g_at_chat_send(gd->chat, "AT*E2GPSCTL=3D1,5,1", none_prefix,
 				mbm_e2gpsctl_enable_cb, cbd, g_free) > 0)
 		return;
 =

-out:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 	g_free(cbd);
 }
-- =

1.7.4.1


--===============2309317724283911531==--

