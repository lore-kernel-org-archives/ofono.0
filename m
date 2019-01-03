Content-Type: multipart/mixed; boundary="===============3823613535996120472=="
MIME-Version: 1.0
From: khaled romdhani <khaledromdhani216@gmail.com>
Subject: [PATCH] Fix voice call initialization problem
Date: Thu, 03 Jan 2019 17:05:40 +0100
Message-ID: <1546531540-31621-1-git-send-email-khaled.romdhani@ardia.com.tn>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3823613535996120472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

when the voice call driver is probing, I noticed sometimes
a CME Error with the code =3D 4 (operation not supported)
related to AT commands "AT+CSSN=3D1,1" and "AT^SLCC=3D1".

In the current voice call implementation for Gemalto modems
the ofono_voicecall_create() is called on the gemalto_pre_sim().
The sim is not totaly readed by the module, it is not yet
online which is causing a sporadic problem at driver
intialization also when launching some outgoing/incoming calls.

This change moves the ofono_voicecall_create() to the
gemalto_post_online() to be sure that sim is well registred
and online.
---
 plugins/gemalto.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 2f84258..eb782a7 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -573,9 +573,6 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", data->app);
 	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
 =

-	ofono_modem_set_integer(modem, "GemaltoVtsQuotes", 1);
-	ofono_voicecall_create(modem, 0, "gemaltomodem", data->app);
-
 	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_GEMALTO, "atmodem",
 						data->app);
 =

@@ -604,11 +601,6 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 =

 	ofono_ussd_create(modem, 0, "atmodem", data->app);
 =

-	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);
-	ofono_call_settings_create(modem, 0, "atmodem", data->app);
-	ofono_call_meter_create(modem, 0, "atmodem", data->app);
-	ofono_call_barring_create(modem, 0, "atmodem", data->app);
-
 	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x))
 		ofono_lte_create(modem, OFONO_VENDOR_GEMALTO,
 						"atmodem", data->app);
@@ -621,6 +613,14 @@ static void gemalto_post_online(struct ofono_modem *mo=
dem)
 	DBG("%p", modem);
 =

 	ofono_netreg_create(modem, OFONO_VENDOR_GEMALTO, "atmodem", data->app);
+	=

+	ofono_modem_set_integer(modem, "GemaltoVtsQuotes", 1);
+	ofono_voicecall_create(modem, 0, "gemaltomodem", data->app);
+
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);
+	ofono_call_settings_create(modem, 0, "atmodem", data->app);
+	ofono_call_meter_create(modem, 0, "atmodem", data->app);
+	ofono_call_barring_create(modem, 0, "atmodem", data->app);
 }
 =

 static struct ofono_modem_driver gemalto_driver =3D {
-- =

1.9.1


--===============3823613535996120472==--

