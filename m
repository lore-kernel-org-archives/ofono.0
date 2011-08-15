Content-Type: multipart/mixed; boundary="===============7360889220627550304=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH v2 2/2] Add cdma voice call status notify
Date: Mon, 15 Aug 2011 10:06:49 +0800
Message-ID: <1313374009-11516-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7360889220627550304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-voicecall.h |    3 ++
 src/cdma-voicecall.c     |   55 ++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/include/cdma-voicecall.h b/include/cdma-voicecall.h
index f12e0b6..badc5eb 100644
--- a/include/cdma-voicecall.h
+++ b/include/cdma-voicecall.h
@@ -66,6 +66,9 @@ struct ofono_cdma_voicecall_driver {
 			ofono_cdma_voicecall_cb_t cb, void *data);
 };
 =

+void ofono_cdma_voicecall_notify(struct ofono_cdma_voicecall *vc,
+	enum cdma_call_status status, const char *number);
+
 void ofono_cdma_voicecall_disconnected(struct ofono_cdma_voicecall *vc,
 					enum ofono_disconnect_reason reason,
 					const struct ofono_error *error);
diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index 47d416c..1af5bdc 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -244,6 +244,32 @@ static void voicecall_set_call_lineid(struct ofono_cdm=
a_voicecall *vc)
 					DBUS_TYPE_STRING, &lineid_str);
 }
 =

+static void voicecall_set_call_waiting_number(struct ofono_cdma_voicecall =
*vc,
+				const struct ofono_cdma_phone_number *ph)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path  =3D __ofono_atom_get_path(vc->atom);
+	const char *waiting_number;
+	ofono_bool_t call_waiting =3D TRUE;
+
+	if (ph->number[0] =3D=3D '\0')
+		return;
+
+	memcpy(&vc->waiting_number, ph, sizeof(struct ofono_cdma_phone_number));
+
+	waiting_number =3D cdma_phone_number_to_string(ph);
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CDMA_VOICECALL_MANAGER_INTERFACE,
+					"CallWaitingNumber", DBUS_TYPE_STRING,
+					&waiting_number);
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CDMA_VOICECALL_MANAGER_INTERFACE,
+					"CallWaiting", DBUS_TYPE_BOOLEAN,
+					&call_waiting);
+}
+
 static void manager_dial_callback(const struct ofono_error *error, void *d=
ata)
 {
 	struct ofono_cdma_voicecall *vc =3D data;
@@ -433,6 +459,35 @@ static GDBusSignalTable manager_signals[] =3D {
 	{ }
 };
 =

+void ofono_cdma_voicecall_notify(struct ofono_cdma_voicecall *vc,
+			enum cdma_call_status status,
+			const char *number)
+{
+	struct ofono_cdma_phone_number ph;
+
+	DBG("status: %d", status);
+
+	memset(&ph, 0, sizeof(struct ofono_cdma_phone_number));
+
+	if (number !=3D NULL) {
+		DBG("lineid: %s", number);
+
+		string_to_cdma_phone_number(number, &ph);
+
+		if (status =3D=3D CDMA_CALL_STATUS_INCOMING
+				&& vc->status =3D=3D CDMA_CALL_STATUS_ACTIVE) {
+			voicecall_set_call_waiting_number(vc, &ph);
+		} else {
+			memcpy(&vc->phone_number, &ph,
+					sizeof(struct ofono_cdma_phone_number));
+
+			voicecall_set_call_lineid(vc);
+		}
+	}
+
+	voicecall_set_call_status(vc, status);
+}
+
 void ofono_cdma_voicecall_disconnected(struct ofono_cdma_voicecall *vc,
 					enum ofono_disconnect_reason reason,
 					const struct ofono_error *error)
-- =

1.7.5


--===============7360889220627550304==--

