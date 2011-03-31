Content-Type: multipart/mixed; boundary="===============1831788916603189899=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC PATCH 8/9] voicecall: generalise emergency call check
Date: Thu, 31 Mar 2011 09:18:31 -0700
Message-ID: <1301588312-6932-9-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1831788916603189899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 4932ffa..f25c770 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -337,14 +337,10 @@ static gint number_compare(gconstpointer a, gconstpoi=
nter b)
 	return strcmp(s1, s2);
 }
 =

-static gboolean voicecall_is_emergency(struct voicecall *v)
+static gboolean is_emergency_number(struct ofono_voicecall *vc,
+					const char *number)
 {
-	struct ofono_call *call =3D v->call;
-	const char *lineid_str;
-
-	lineid_str =3D phone_number_to_string(&call->phone_number);
-
-	return g_slist_find_custom(v->vc->en_list, lineid_str,
+	return g_slist_find_custom(vc->en_list, number,
 						number_compare) ? TRUE : FALSE;
 }
 =

@@ -417,7 +413,7 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 		ofono_dbus_dict_append(dict, "Icon",
 						DBUS_TYPE_BYTE, &v->icon_id);
 =

-	if (voicecall_is_emergency(v) =3D=3D TRUE)
+	if (is_emergency_number(v->vc, callerid) =3D=3D TRUE)
 		emergency_call =3D TRUE;
 	else
 		emergency_call =3D FALSE;
@@ -788,7 +784,7 @@ static void voicecall_set_call_lineid(struct voicecall =
*v,
 						"LineIdentification",
 						DBUS_TYPE_STRING, &lineid_str);
 =

-	if (voicecall_is_emergency(v)) {
+	if (is_emergency_number(v->vc, lineid_str)) {
 		dbus_bool_t emergency_call =3D TRUE;
 =

 		ofono_dbus_signal_property_changed(conn, path,
-- =

1.7.0.4


--===============1831788916603189899==--

