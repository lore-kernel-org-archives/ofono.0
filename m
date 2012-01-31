Content-Type: multipart/mixed; boundary="===============2930100019492082568=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 2/5] call-forwarding: Minor refactoring of is_cfu_enabled()
Date: Tue, 31 Jan 2012 11:50:34 +0200
Message-ID: <1328003437-20498-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1328003437-20498-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2930100019492082568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This also removes the need for uninitialized_var() macro.
---
 src/call-forwarding.c |   36 +++++++++++++++++-------------------
 1 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 731a38a..8b8d5a8 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -36,14 +36,17 @@
 #include "common.h"
 #include "simutil.h"
 =

-#define uninitialized_var(x) x =3D x
-
 #define CALL_FORWARDING_FLAG_CACHED	0x1
 #define CALL_FORWARDING_FLAG_CPHS_CFF	0x2
 =

 /* According to 27.007 Spec */
 #define DEFAULT_NO_REPLY_TIMEOUT 20
 =

+#define is_cfu_enabled(_cf)				\
+({							\
+	cf_find_unconditional(_cf) ? TRUE : FALSE;	\
+})
+
 enum call_forwarding_type {
 	CALL_FORWARDING_TYPE_UNCONDITIONAL =3D	0,
 	CALL_FORWARDING_TYPE_BUSY =3D		1,
@@ -221,8 +224,8 @@ static void sim_cphs_cff_update_cb(int ok, void *data)
 		ofono_info("Failed to update EFcphs-cff");
 }
 =

-static gboolean is_cfu_enabled(struct ofono_call_forwarding *cf,
-				struct ofono_call_forwarding_condition **out)
+static struct ofono_call_forwarding_condition *cf_find_unconditional(
+					struct ofono_call_forwarding *cf)
 {
 	GSList *l =3D cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL];
 	struct ofono_call_forwarding_condition *cond;
@@ -237,21 +240,16 @@ static gboolean is_cfu_enabled(struct ofono_call_forw=
arding *cf,
 		if (cond->cls > BEARER_CLASS_VOICE)
 			continue;
 =

-		if (out)
-			*out =3D cond;
-
-		return TRUE;
+		return cond;
 	}
 =

-	return FALSE;
+	return NULL;
 }
 =

 static void sim_set_cf_indicator(struct ofono_call_forwarding *cf)
 {
-	gboolean cfu_voice;
-	struct ofono_call_forwarding_condition *uninitialized_var(cond);
-
-	cfu_voice =3D is_cfu_enabled(cf, &cond);
+	struct ofono_call_forwarding_condition *cfu_voice =3D
+						cf_find_unconditional(cf);
 =

 	if (cf->cfis_record_id) {
 		unsigned char data[16];
@@ -263,15 +261,15 @@ static void sim_set_cf_indicator(struct ofono_call_fo=
rwarding *cf)
 		data[0] =3D 0x01;
 =

 		if (cfu_voice) {
-			number_len =3D strlen(cond->phone_number.number);
+			number_len =3D strlen(cfu_voice->phone_number.number);
 =

 			/* CFU indicator Status - Voice */
 			data[1] =3D 0x01;
 			number_len =3D (number_len + 1) / 2;
 			data[2] =3D number_len + 1;
-			data[3] =3D cond->phone_number.type;
+			data[3] =3D cfu_voice->phone_number.type;
 =

-			sim_encode_bcd_number(cond->phone_number.number,
+			sim_encode_bcd_number(cfu_voice->phone_number.number,
 						data + 4);
 		} else {
 			data[1] =3D 0x00;
@@ -317,7 +315,7 @@ static void set_new_cond_list(struct ofono_call_forward=
ing *cf,
 =

 	if ((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
 			cf->cfis_record_id > 0)
-		old_cfu =3D is_cfu_enabled(cf, NULL);
+		old_cfu =3D is_cfu_enabled(cf);
 	else
 		old_cfu =3D FALSE;
 =

@@ -432,7 +430,7 @@ static void set_new_cond_list(struct ofono_call_forward=
ing *cf,
 =

 	if ((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
 			cf->cfis_record_id > 0)
-		new_cfu =3D is_cfu_enabled(cf, NULL);
+		new_cfu =3D is_cfu_enabled(cf);
 	else
 		new_cfu =3D FALSE;
 =

@@ -523,7 +521,7 @@ static DBusMessage *cf_get_properties_reply(DBusMessage=
 *msg,
 =

 	if ((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
 			cf->cfis_record_id > 0)
-		status =3D is_cfu_enabled(cf, NULL);
+		status =3D is_cfu_enabled(cf);
 	else
 		status =3D FALSE;
 =

-- =

1.7.5.4


--===============2930100019492082568==--

