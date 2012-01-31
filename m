Content-Type: multipart/mixed; boundary="===============0863903800389475723=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 4/5] call-forwarding: Don't report conditional cfs when cfu is
 active
Date: Tue, 31 Jan 2012 11:50:36 +0200
Message-ID: <1328003437-20498-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1328003437-20498-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0863903800389475723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 37d4378..8a38c0b 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -503,6 +503,8 @@ static DBusMessage *cf_get_properties_reply(DBusMessage=
 *msg,
 	DBusMessageIter dict;
 	int i;
 	dbus_bool_t status;
+	gboolean cfu_enabled;
+	GSList *cf_list;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -514,14 +516,26 @@ static DBusMessage *cf_get_properties_reply(DBusMessa=
ge *msg,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 						&dict);
 =

-	for (i =3D 0; i < 4; i++)
-		property_append_cf_conditions(&dict, cf->cf_conditions[i],
+	cfu_enabled =3D is_cfu_enabled(cf);
+
+	for (i =3D 0; i < 4; i++) {
+
+		/*
+		 * Report conditional cfs as empty when CFU is active
+		 */
+		if (cfu_enabled && (i !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL))
+			cf_list =3D NULL;
+		else
+			cf_list =3D cf->cf_conditions[i];
+
+		property_append_cf_conditions(&dict, cf_list,
 						BEARER_CLASS_VOICE,
 						cf_type_lut[i]);
+	}
 =

 	if ((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
 			cf->cfis_record_id > 0)
-		status =3D is_cfu_enabled(cf);
+		status =3D cfu_enabled;
 	else
 		status =3D FALSE;
 =

-- =

1.7.5.4


--===============0863903800389475723==--

