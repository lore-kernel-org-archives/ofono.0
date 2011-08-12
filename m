Content-Type: multipart/mixed; boundary="===============8257350955849701274=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH 1/2] Add call waiting support in CDMA voice call
Date: Fri, 12 Aug 2011 17:20:15 +0800
Message-ID: <1313140815-29052-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8257350955849701274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-voicecall.c |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index bbf805f..47d416c 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -40,6 +40,7 @@ static GSList *g_drivers;
 =

 struct ofono_cdma_voicecall {
 	struct ofono_cdma_phone_number phone_number;
+	struct ofono_cdma_phone_number waiting_number;
 	int direction;
 	enum cdma_call_status status;
 	time_t start_time;
@@ -108,14 +109,33 @@ static void append_voicecall_properties(struct ofono_=
cdma_voicecall *vc,
 {
 	const char *status;
 	const char *lineid;
+	const char *waiting_call =3D NULL;
+	ofono_bool_t call_waiting;
 =

 	status =3D cdma_call_status_to_string(vc->status);
-	lineid =3D cdma_phone_number_to_string(&vc->phone_number);
 =

 	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING, &status);
 =

-	ofono_dbus_dict_append(dict, "LineIdentification",
-				DBUS_TYPE_STRING, &lineid);
+	if (vc->status !=3D CDMA_CALL_STATUS_DISCONNECTED) {
+		if (vc->phone_number.number[0] !=3D '\0') {
+			lineid =3D cdma_phone_number_to_string(&vc->phone_number);
+			ofono_dbus_dict_append(dict, "LineIdentification",
+						DBUS_TYPE_STRING, &lineid);
+		}
+
+		if (vc->waiting_number.number[0] !=3D '\0') {
+			waiting_call =3D cdma_phone_number_to_string(
+						&vc->waiting_number);
+
+			ofono_dbus_dict_append(dict, "CallWaitingNumber",
+					DBUS_TYPE_STRING, &waiting_call);
+		}
+	}
+
+	call_waiting =3D (waiting_call !=3D NULL);
+
+	ofono_dbus_dict_append(dict, "CallWaiting",
+					DBUS_TYPE_BOOLEAN, &call_waiting);
 =

 	if (vc->status =3D=3D CDMA_CALL_STATUS_ACTIVE) {
 		const char *timestr =3D time_to_str(&vc->start_time);
@@ -172,6 +192,7 @@ static void voicecall_set_call_status(struct ofono_cdma=
_voicecall *vc,
 	const char *status_str;
 	enum cdma_call_status old_status;
 =

+	DBG("status: %s", cdma_call_status_to_string(status));
 	if (vc->status =3D=3D status)
 		return;
 =

@@ -198,6 +219,14 @@ static void voicecall_set_call_status(struct ofono_cdm=
a_voicecall *vc,
 					"StartTime", DBUS_TYPE_STRING,
 					&timestr);
 	}
+
+	if (status =3D=3D CDMA_CALL_STATUS_DISCONNECTED) {
+		memset(&vc->phone_number, 0,
+				sizeof(struct ofono_cdma_phone_number));
+
+		memset(&vc->waiting_number, 0,
+			sizeof(struct ofono_cdma_phone_number));
+	}
 }
 =

 static void voicecall_set_call_lineid(struct ofono_cdma_voicecall *vc)
-- =

1.7.5


--===============8257350955849701274==--

