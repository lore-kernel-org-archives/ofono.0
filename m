Content-Type: multipart/mixed; boundary="===============5703204677928183778=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 5/5] call-forwarding: Emit signals to mask/unmask conditional
 cfs
Date: Tue, 31 Jan 2012 11:50:37 +0200
Message-ID: <1328003437-20498-6-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1328003437-20498-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5703204677928183778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Emit signals to mask/unmask conditional cfs on cfu
activation/deactivation.
---
 src/call-forwarding.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 8a38c0b..57af5a4 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -436,6 +436,36 @@ static void set_new_cond_list(struct ofono_call_forwar=
ding *cf,
 =

 	if (new_cfu !=3D old_cfu) {
 		ofono_bool_t status =3D new_cfu;
+		int i;
+
+		/*
+		 * Emit signals to mask/unmask conditional cfs on cfu change
+		 */
+		for (i =3D 0; i < 4; i++) {
+			if (i =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL)
+				continue;
+
+			l =3D g_slist_find_custom(cf->cf_conditions[i],
+					GINT_TO_POINTER(BEARER_CLASS_VOICE),
+					cf_condition_find_with_cls);
+
+			if (l =3D=3D NULL)
+				continue;
+
+			if (new_cfu)
+				number =3D "";
+			else {
+				lc =3D l->data;
+
+				number =3D phone_number_to_string(
+							&lc->phone_number);
+			}
+
+			ofono_dbus_signal_property_changed(conn, path,
+						OFONO_CALL_FORWARDING_INTERFACE,
+						cf_type_lut[i],
+						DBUS_TYPE_STRING, &number);
+		}
 =

 		ofono_dbus_signal_property_changed(conn, path,
 					OFONO_CALL_FORWARDING_INTERFACE,
-- =

1.7.5.4


--===============5703204677928183778==--

