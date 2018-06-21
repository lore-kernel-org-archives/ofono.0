Content-Type: multipart/mixed; boundary="===============2811316433792294880=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 07/12] stemodem: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:20:56 +0300
Message-ID: <1529601661-4856-7-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2811316433792294880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/voicecall.c | 77 +++++++++++++++++++++++-----------------=
----
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 356ab7c..eb4431c 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -82,28 +82,29 @@ static int call_status_ste_to_ofono(enum call_status_st=
e status)
 	switch (status) {
 	case STE_CALL_STATUS_IDLE:
 	case STE_CALL_STATUS_RELEASED:
-		return CALL_STATUS_DISCONNECTED;
+		return OFONO_CALL_STATUS_DISCONNECTED;
 	case STE_CALL_STATUS_CALLING:
-		return CALL_STATUS_DIALING;
+		return OFONO_CALL_STATUS_DIALING;
 	case STE_CALL_STATUS_CONNECTING:
-		return CALL_STATUS_ALERTING;
+		return OFONO_CALL_STATUS_ALERTING;
 	case STE_CALL_STATUS_ACTIVE:
-		return CALL_STATUS_ACTIVE;
+		return OFONO_CALL_STATUS_ACTIVE;
 	case STE_CALL_STATUS_HOLD:
-		return CALL_STATUS_HELD;
+		return OFONO_CALL_STATUS_HELD;
 	case STE_CALL_STATUS_WAITING:
-		return CALL_STATUS_WAITING;
+		return OFONO_CALL_STATUS_WAITING;
 	case STE_CALL_STATUS_ALERTING:
-		return CALL_STATUS_INCOMING;
+		return OFONO_CALL_STATUS_INCOMING;
 	case STE_CALL_STATUS_BUSY:
-		return CALL_STATUS_DISCONNECTED;
+		return OFONO_CALL_STATUS_DISCONNECTED;
 	}
 =

-	return CALL_STATUS_DISCONNECTED;
+	return OFONO_CALL_STATUS_DISCONNECTED;
 }
 =

 static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
-					int direction, int status,
+					enum ofono_call_direction direction,
+					enum ofono_call_status status,
 					const char *num, int num_type, int clip)
 {
 	struct voicecall_data *d =3D ofono_voicecall_get_data(vc);
@@ -120,7 +121,7 @@ static struct ofono_call *create_call(struct ofono_voic=
ecall *vc, int type,
 	call->direction =3D direction;
 	call->status =3D status;
 =

-	if (clip !=3D CLIP_VALIDITY_NOT_AVAILABLE) {
+	if (clip !=3D OFONO_CLIP_VALIDITY_NOT_AVAILABLE) {
 		strncpy(call->phone_number.number, num,
 			OFONO_MAX_PHONE_NUMBER_LENGTH);
 		call->phone_number.type =3D num_type;
@@ -255,10 +256,10 @@ static void ste_hangup(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	unsigned int active_dial_alert_or_incoming =3D
-			(1 << CALL_STATUS_ACTIVE) |
-			(1 << CALL_STATUS_DIALING) |
-			(1 << CALL_STATUS_ALERTING) |
-			(1 << CALL_STATUS_INCOMING);
+			(1 << OFONO_CALL_STATUS_ACTIVE) |
+			(1 << OFONO_CALL_STATUS_DIALING) |
+			(1 << OFONO_CALL_STATUS_ALERTING) |
+			(1 << OFONO_CALL_STATUS_INCOMING);
 =

 	ste_template("AT+CHUP", vc, ste_generic_cb,
 			active_dial_alert_or_incoming, cb, data);
@@ -273,7 +274,7 @@ static void ste_hold_all_active(struct ofono_voicecall =
*vc,
 static void ste_release_all_held(struct ofono_voicecall *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int held =3D 1 << CALL_STATUS_HELD;
+	unsigned int held =3D 1 << OFONO_CALL_STATUS_HELD;
 =

 	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, held, cb, data);
 }
@@ -282,7 +283,8 @@ static void ste_set_udub(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	unsigned int incoming_or_waiting =3D
-			(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
+			(1 << OFONO_CALL_STATUS_INCOMING) |
+			(1 << OFONO_CALL_STATUS_WAITING);
 =

 	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, incoming_or_waiting,
 			cb, data);
@@ -291,7 +293,7 @@ static void ste_set_udub(struct ofono_voicecall *vc,
 static void ste_release_all_active(struct ofono_voicecall *vc,
 					ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int active =3D 1 << CALL_STATUS_ACTIVE;
+	unsigned int active =3D 1 << OFONO_CALL_STATUS_ACTIVE;
 =

 	ste_template("AT+CHLD=3D1", vc, ste_generic_cb, active, cb, data);
 }
@@ -359,7 +361,8 @@ static void ste_deflect(struct ofono_voicecall *vc,
 {
 	char buf[128];
 	unsigned int incoming_or_waiting =3D
-		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
+		(1 << OFONO_CALL_STATUS_INCOMING) |
+		(1 << OFONO_CALL_STATUS_WAITING);
 =

 	snprintf(buf, sizeof(buf), "AT+CTFR=3D\"%s\",%d", ph->number, ph->type);
 	ste_template(buf, vc, ste_generic_cb, incoming_or_waiting, cb, data);
@@ -442,9 +445,9 @@ static void ecav_notify(GAtResult *result, gpointer use=
r_data)
 =

 	status =3D call_status_ste_to_ofono(status);
 =

-	if (status =3D=3D CALL_STATUS_DIALING ||
-			status =3D=3D CALL_STATUS_WAITING ||
-			status =3D=3D CALL_STATUS_INCOMING) {
+	if (status =3D=3D OFONO_CALL_STATUS_DIALING ||
+			status =3D=3D OFONO_CALL_STATUS_WAITING ||
+			status =3D=3D OFONO_CALL_STATUS_INCOMING) {
 		/*
 		 * If caller uses hidden id, the number and
 		 * number type might not be present. Don't
@@ -467,16 +470,16 @@ static void ecav_notify(GAtResult *result, gpointer u=
ser_data)
 	if (l)
 		existing_call =3D l->data;
 =

-	if (l =3D=3D NULL && status !=3D CALL_STATUS_DIALING &&
-				status !=3D CALL_STATUS_WAITING &&
-				status !=3D CALL_STATUS_INCOMING) {
+	if (l =3D=3D NULL && status !=3D OFONO_CALL_STATUS_DIALING &&
+				status !=3D OFONO_CALL_STATUS_WAITING &&
+				status !=3D OFONO_CALL_STATUS_INCOMING) {
 		ofono_error("ECAV notification for unknown call."
 				" id: %d, status: %d", id, status);
 		return;
 	}
 =

 	switch (status) {
-	case CALL_STATUS_DISCONNECTED: {
+	case OFONO_CALL_STATUS_DISCONNECTED: {
 		enum ofono_disconnect_reason reason;
 =

 		existing_call->status =3D status;
@@ -495,21 +498,21 @@ static void ecav_notify(GAtResult *result, gpointer u=
ser_data)
 		break;
 	}
 =

-	case CALL_STATUS_DIALING:
-	case CALL_STATUS_WAITING:
-	case CALL_STATUS_INCOMING: {
+	case OFONO_CALL_STATUS_DIALING:
+	case OFONO_CALL_STATUS_WAITING:
+	case OFONO_CALL_STATUS_INCOMING: {
 		int clip_validity;
 		int direction;
 =

-		if (status =3D=3D CALL_STATUS_DIALING)
-			direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
+		if (status =3D=3D OFONO_CALL_STATUS_DIALING)
+			direction =3D OFONO_CALL_DIRECTION_MOBILE_ORIGINATED;
 		else
-			direction =3D CALL_DIRECTION_MOBILE_TERMINATED;
+			direction =3D OFONO_CALL_DIRECTION_MOBILE_TERMINATED;
 =

 		if (strlen(num) > 0)
-			clip_validity =3D CLIP_VALIDITY_VALID;
+			clip_validity =3D OFONO_CLIP_VALIDITY_VALID;
 		else
-			clip_validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
+			clip_validity =3D OFONO_CLIP_VALIDITY_NOT_AVAILABLE;
 =

 		new_call =3D create_call(vc, call_type, direction, status,
 					num, num_type, clip_validity);
@@ -524,9 +527,9 @@ static void ecav_notify(GAtResult *result, gpointer use=
r_data)
 		break;
 	}
 =

-	case CALL_STATUS_ALERTING:
-	case CALL_STATUS_ACTIVE:
-	case CALL_STATUS_HELD:
+	case OFONO_CALL_STATUS_ALERTING:
+	case OFONO_CALL_STATUS_ACTIVE:
+	case OFONO_CALL_STATUS_HELD:
 		existing_call->status =3D status;
 		ofono_voicecall_notify(vc, existing_call);
 		break;
-- =

1.9.1


--===============2811316433792294880==--

