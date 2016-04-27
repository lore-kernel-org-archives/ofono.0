Content-Type: multipart/mixed; boundary="===============3667540559802761979=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] Radio-setting: Fix to init pending band
Date: Thu, 28 Apr 2016 04:30:49 +0530
Message-ID: <1461798049-11951-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3667540559802761979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara Borwankar <antara.borwankar@gmail.com>

Initialiing rs->pending_band_gsm and rs->pending_band_umts
---
 src/radio-settings.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index 5ab4e7b..8cb3d41 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -855,6 +855,8 @@ static void radio_load_settings(struct ofono_radio_sett=
ings *rs,
 						"GsmBand", rs->band_gsm);
 	}
 =

+	rs->pending_band_gsm =3D rs->band_gsm;
+
 	error =3D NULL;
 	rs->band_umts =3D g_key_file_get_integer(rs->settings, SETTINGS_GROUP,
 					"UmtsBand", &error);
@@ -865,6 +867,8 @@ static void radio_load_settings(struct ofono_radio_sett=
ings *rs,
 						"UmtsBand", rs->band_umts);
 	}
 =

+	rs->pending_band_umts =3D rs->band_umts;
+
 	error =3D NULL;
 	rs->mode =3D g_key_file_get_integer(rs->settings, SETTINGS_GROUP,
 					"TechnologyPreference", &error);
@@ -890,10 +894,8 @@ void ofono_radio_settings_register(struct ofono_radio_=
settings *rs)
 =

 	radio_load_settings(rs, ofono_sim_get_imsi(sim));
 =

-	if (rs->driver->set_band =3D=3D NULL)
-		goto finish;
-
-	rs->driver->set_band(rs, rs->band_gsm, rs->band_umts,
+	if (rs->driver->set_band !=3D NULL)
+		rs->driver->set_band(rs, rs->band_gsm, rs->band_umts,
 					radio_band_set_callback_at_reg, rs);
 =

 	if (rs->driver->set_rat_mode =3D=3D NULL)
-- =

1.9.1


--===============3667540559802761979==--

