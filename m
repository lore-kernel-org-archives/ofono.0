Content-Type: multipart/mixed; boundary="===============1712771485233367895=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] radio-settings: Fix memory leaks in radio_load_settings
Date: Fri, 02 Jun 2017 18:41:04 +0300
Message-ID: <1496418064-7713-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1712771485233367895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Errors returned by g_key_file_get_integer have to be deallocated
by the caller to avoid leaks like these:

=3D=3D13330=3D=3D 104 (24 direct, 80 indirect) bytes in 2 blocks are defini=
tely lost
=3D=3D13330=3D=3D    at 0x483F3EC: malloc (vg_replace_malloc.c)
=3D=3D13330=3D=3D    by 0x4B020DF: g_malloc (gmem.c)
=3D=3D13330=3D=3D    by 0x4B17F51: g_slice_alloc (gslice.c)
=3D=3D13330=3D=3D    by 0x4AE80B9: g_error_new_valist (gerror.c)
=3D=3D13330=3D=3D    by 0x4AE830B: g_set_error (gerror.c)
=3D=3D13330=3D=3D    by 0x4AF5681: g_key_file_get_value (gkeyfile.c)
=3D=3D13330=3D=3D    by 0x4AF6817: g_key_file_get_integer (gkeyfile.c)
=3D=3D13330=3D=3D    by 0x10CFE3: radio_load_settings (radio-settings.c)
=3D=3D13330=3D=3D    by 0x10D2E3: ofono_radio_settings_register (radio-sett=
ings.c)
---
 src/radio-settings.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index b988e3e..4f81a84 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -856,9 +856,13 @@ static void radio_load_settings(struct ofono_radio_set=
tings *rs,
 						"GsmBand", rs->band_gsm);
 	}
 =

+	if (error) {
+		g_error_free(error);
+		error =3D NULL;
+	}
+
 	rs->pending_band_gsm =3D rs->band_gsm;
 =

-	error =3D NULL;
 	rs->band_umts =3D g_key_file_get_integer(rs->settings, SETTINGS_GROUP,
 					"UmtsBand", &error);
 =

@@ -868,9 +872,13 @@ static void radio_load_settings(struct ofono_radio_set=
tings *rs,
 						"UmtsBand", rs->band_umts);
 	}
 =

+	if (error) {
+		g_error_free(error);
+		error =3D NULL;
+	}
+
 	rs->pending_band_umts =3D rs->band_umts;
 =

-	error =3D NULL;
 	rs->mode =3D g_key_file_get_integer(rs->settings, SETTINGS_GROUP,
 					"TechnologyPreference", &error);
 =

@@ -880,6 +888,11 @@ static void radio_load_settings(struct ofono_radio_set=
tings *rs,
 					"TechnologyPreference", rs->mode);
 	}
 =

+	if (error) {
+		g_error_free(error);
+		error =3D NULL;
+	}
+
 	DBG("TechnologyPreference: %d", rs->mode);
 	DBG("GsmBand: %d", rs->band_gsm);
 	DBG("UmtsBand: %d", rs->band_umts);
-- =

1.9.1


--===============1712771485233367895==--

