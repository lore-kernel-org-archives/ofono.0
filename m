Content-Type: multipart/mixed; boundary="===============7142532021514157947=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/2] plugins/gemalto: added voice support
Date: Wed, 17 Oct 2018 19:10:37 +0200
Message-ID: <20181017171037.14324-2-gciofono@gmail.com>
In-Reply-To: <20181017171037.14324-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7142532021514157947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The plugin for Gemalto modems is enriched with all voice-related atoms,
as well as USSD.
All except the voicecall itself are from the atmodem, while the
voicecall is from gemaltomodem.
---
 plugins/gemalto.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 0fcf30d8..5d3c77a9 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -571,6 +572,10 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->app);
 	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
+
+	ofono_modem_set_integer(modem, "GemaltoVtsQuotes", 1);
+	ofono_voicecall_create(modem, 0, "gemaltomodem", data->app);
+
 	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_GEMALTO, "atmodem",
 						data->app);
 =

@@ -597,6 +602,13 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
 =

+	ofono_ussd_create(modem, 0, "atmodem", data->app);
+
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);
+	ofono_call_settings_create(modem, 0, "atmodem", data->app);
+	ofono_call_meter_create(modem, 0, "atmodem", data->app);
+	ofono_call_barring_create(modem, 0, "atmodem", data->app);
+
 	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x))
 		ofono_lte_create(modem, OFONO_VENDOR_CINTERION,
 						"atmodem", data->app);
-- =

2.17.1


--===============7142532021514157947==--

