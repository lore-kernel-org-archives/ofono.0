Content-Type: multipart/mixed; boundary="===============4231119648821856054=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/4] call-settings: rename CalledLine* properties
Date: Wed, 29 Dec 2010 00:41:00 -0200
Message-ID: <1293590462-3516-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1293590462-3516-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4231119648821856054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

COLP and COLR are better named respectively as ConnectedLinePresentation
and ConnectedLineRestriction as stated in 27.007 sections 7.8 and 7.31.

CalledLine* name will be used in future for CDIP.
---
 src/call-settings.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index aea4991..4dac2b6 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -289,7 +289,7 @@ static void set_colp(struct ofono_call_settings *cs, in=
t colp)
 =

 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_CALL_SETTINGS_INTERFACE,
-						"CalledLinePresentation",
+						"ConnectedLinePresentation",
 						DBUS_TYPE_STRING, &str);
 }
 =

@@ -311,7 +311,7 @@ static void set_colr(struct ofono_call_settings *cs, in=
t colr)
 =

 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_CALL_SETTINGS_INTERFACE,
-						"CalledLineRestriction",
+						"ConnectedLineRestriction",
 						DBUS_TYPE_STRING, &str);
 }
 =

@@ -595,13 +595,13 @@ static void clip_cnap_colp_colr_ss_query_cb(const str=
uct ofono_error *error,
 	case CALL_SETTING_TYPE_COLP:
 		set_colp(cs, status);
 		value =3D colp_status_to_string(status);
-		context =3D "CalledLinePresentation";
+		context =3D "ConnectedLinePresentation";
 		break;
 =

 	case CALL_SETTING_TYPE_COLR:
 		set_colr(cs, status);
 		value =3D colr_status_to_string(status);
-		context =3D "CalledLineRestriction";
+		context =3D "ConnectedLineRestriction";
 		break;
 =

 	default:
@@ -875,11 +875,11 @@ static DBusMessage *generate_get_properties_reply(str=
uct ofono_call_settings *cs
 				DBUS_TYPE_STRING, &str);
 =

 	str =3D colp_status_to_string(cs->colp);
-	ofono_dbus_dict_append(&dict, "CalledLinePresentation",
+	ofono_dbus_dict_append(&dict, "ConnectedLinePresentation",
 				DBUS_TYPE_STRING, &str);
 =

 	str =3D colr_status_to_string(cs->colr);
-	ofono_dbus_dict_append(&dict, "CalledLineRestriction",
+	ofono_dbus_dict_append(&dict, "ConnectedLineRestriction",
 				DBUS_TYPE_STRING, &str);
 =

 	str =3D clir_status_to_string(cs->clir);
-- =

1.7.3.4


--===============4231119648821856054==--

