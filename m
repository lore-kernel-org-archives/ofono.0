Content-Type: multipart/mixed; boundary="===============2298222586248063801=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] call-settings: use enum values
Date: Tue, 25 Jan 2011 21:46:08 -0200
Message-ID: <1295999168-1168-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2298222586248063801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the enum values defined for CLIP, CNAP, CLIR, COLP and COLR.
---
 src/call-settings.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index 109f130..8dd2564 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -1179,11 +1179,11 @@ static DBusMessage *set_clir(DBusMessage *msg, stru=
ct ofono_call_settings *cs,
 		return __ofono_error_not_implemented(msg);
 =

 	if (!strcmp(setting, "default"))
-		clir =3D 0;
+		clir =3D CLIR_STATUS_NOT_PROVISIONED;
 	else if (!strcmp(setting, "enabled"))
-		clir =3D 1;
+		clir =3D CLIR_STATUS_PROVISIONED_PERMANENT;
 	else if (!strcmp(setting, "disabled"))
-		clir =3D 2;
+		clir =3D CLIR_STATUS_UNKNOWN;
 =

 	if (clir =3D=3D -1)
 		return __ofono_error_invalid_format(msg);
@@ -1411,11 +1411,11 @@ struct ofono_call_settings *ofono_call_settings_cre=
ate(struct ofono_modem *modem
 		return NULL;
 =

 	/* Set all the settings to unknown state */
-	cs->clip =3D 2;
-	cs->cnap =3D 2;
-	cs->clir =3D 2;
-	cs->colp =3D 2;
-	cs->colr =3D 2;
+	cs->clip =3D CLIP_STATUS_UNKNOWN;
+	cs->cnap =3D CNAP_STATUS_UNKNOWN;
+	cs->clir =3D CLIR_STATUS_UNKNOWN;
+	cs->colp =3D COLP_STATUS_UNKNOWN;
+	cs->colr =3D COLR_STATUS_UNKNOWN;
 	cs->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_CALL_SETTINGS,
 						call_settings_remove, cs);
 =

-- =

1.7.3.5


--===============2298222586248063801==--

