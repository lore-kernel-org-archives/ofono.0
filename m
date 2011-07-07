Content-Type: multipart/mixed; boundary="===============2996228195925522562=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Create gprs and gc in post_sim,
 because in post_online could lead to problems.
Date: Thu, 07 Jul 2011 18:41:20 +0200
Message-ID: <1310056880-11204-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2996228195925522562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/zte.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/plugins/zte.c b/plugins/zte.c
index 6a4b374..4bac3cf 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -286,6 +286,13 @@ static void zte_post_sim(struct ofono_modem *modem)
 =

 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 					"atmodem", data->aux);
+
+	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->aux);
+
+	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+
+	if (data->gprs && data->gc)
+		ofono_gprs_add_context(data->gprs, data->gc);
 }
 =

 static void zte_post_online(struct ofono_modem *modem)
@@ -300,12 +307,6 @@ static void zte_post_online(struct ofono_modem *modem)
 					"atmodem", data->aux);
 	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 					"atmodem", data->aux);
-	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->aux);
-
-	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
-
-	if (data->gprs && data->gc)
-		ofono_gprs_add_context(data->gprs, data->gc);
 }
 =

 static struct ofono_modem_driver zte_driver =3D {
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============2996228195925522562==--

