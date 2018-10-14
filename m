Content-Type: multipart/mixed; boundary="===============1302256828953361165=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v2 2/2] plugins/gemalto: added voice support
Date: Sun, 14 Oct 2018 16:17:28 +0200
Message-ID: <20181014141728.20227-3-gciofono@gmail.com>
In-Reply-To: <20181014141728.20227-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1302256828953361165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The plugin for Gemalto modems is enriched with all voice-related atoms,
as well as USSD.
All except the voicecall itself are from the atmodem, while the
voicecall is from gemaltomodem.
---
 plugins/gemalto.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 0fcf30d8..8a965748 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -571,6 +571,10 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
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

@@ -597,6 +601,13 @@ static void gemalto_post_sim(struct ofono_modem *modem)
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


--===============1302256828953361165==--

