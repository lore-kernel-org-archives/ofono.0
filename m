Content-Type: multipart/mixed; boundary="===============8079431408531641749=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 3/5] call-forwarding: Don't set conditional cfs when cfu is
 active
Date: Tue, 31 Jan 2012 11:50:35 +0200
Message-ID: <1328003437-20498-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1328003437-20498-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8079431408531641749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 8b8d5a8..37d4378 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -802,6 +802,13 @@ static DBusMessage *cf_set_property(DBusConnection *co=
nn, DBusMessage *msg,
 		if (strlen(number) > 0 && !valid_phone_number_format(number))
 			return __ofono_error_invalid_format(msg);
 =

+		/*
+		 * Don't set conditional cfs when cfu is active
+		 */
+		if (type !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
+				is_cfu_enabled(cf) && number[0] !=3D '\0')
+			return __ofono_error_not_available(msg);
+
 		if (number[0] !=3D '\0')
 			string_to_phone_number(number, &ph);
 =

@@ -1159,6 +1166,17 @@ static gboolean cf_ss_control(int type, const char *=
sc,
 		return TRUE;
 	}
 =

+	/*
+	 * Don't set conditional cfs when cfu is active
+	 */
+	if (type =3D=3D SS_CONTROL_TYPE_REGISTRATION &&
+			cf_type !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
+			is_cfu_enabled(cf) && sia[0] !=3D '\0') {
+		g_dbus_send_message(conn, __ofono_error_not_available(msg));
+
+		return TRUE;
+	}
+
 	cf->ss_req =3D g_try_new0(struct cf_ss_request, 1);
 =

 	if (cf->ss_req =3D=3D NULL) {
-- =

1.7.5.4


--===============8079431408531641749==--

