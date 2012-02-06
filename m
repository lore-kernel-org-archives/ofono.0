Content-Type: multipart/mixed; boundary="===============6016142075612522048=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 5/8] call-forwarding: Emit signals to mask/unmask
 conditional cfs
Date: Mon, 06 Feb 2012 14:33:58 +0200
Message-ID: <1328531641-10612-6-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1328531641-10612-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6016142075612522048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Emit signals to mask/unmask conditional cfs on cfu
activation/deactivation.
---
 src/call-forwarding.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index f9bee6b..7b086e0 100644
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


--===============6016142075612522048==--

