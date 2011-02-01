Content-Type: multipart/mixed; boundary="===============6782233672762123198=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 1/2] isimodem: fix problems in call state reporting
Date: Wed, 02 Feb 2011 00:22:09 +0200
Message-ID: <1296598930-3093-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6782233672762123198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Do not report early incoming calls.

Report "disconnected" state separately.

Call ofono_voicecall_disconnected() only after call id is released.
---
 drivers/isimodem/voicecall.c |   84 ++++++++++++++++++++++++++++++--------=
----
 1 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 6a1e582..6e23986 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -363,10 +363,13 @@ static int isi_call_status_to_clcc(const struct isi_c=
all *call)
 	case CALL_STATUS_WAITING:
 		return 5;
 =

-	case CALL_STATUS_ANSWERED:
-	case CALL_STATUS_ACTIVE:
 	case CALL_STATUS_MO_RELEASE:
 	case CALL_STATUS_MT_RELEASE:
+	case CALL_STATUS_TERMINATED:
+		return 6;
+
+	case CALL_STATUS_ANSWERED:
+	case CALL_STATUS_ACTIVE:
 	case CALL_STATUS_HOLD_INITIATED:
 		return 0;
 =

@@ -375,11 +378,10 @@ static int isi_call_status_to_clcc(const struct isi_c=
all *call)
 		return 1;
 =

 	case CALL_STATUS_RECONNECT_PENDING:
-	case CALL_STATUS_TERMINATED:
 	case CALL_STATUS_SWAP_INITIATED:
+	default:
 		return 0;
 	}
-	return 0;
 }
 =

 static struct ofono_call isi_call_as_ofono_call(const struct isi_call *cal=
l)
@@ -433,13 +435,27 @@ static struct isi_call *isi_call_set_idle(struct isi_=
call *call)
 	return call;
 }
 =

-static void isi_call_release(struct ofono_voicecall *ovc, struct isi_call =
*call)
+static void isi_call_disconnected(struct ofono_voicecall *ovc,
+					struct isi_call *call)
 {
 	struct ofono_error error =3D {
 		OFONO_ERROR_TYPE_NO_ERROR, 0
 	};
+
+	DBG("disconnected id=3D%u reason=3D%u", call->id, call->reason);
+
+	ofono_voicecall_disconnected(ovc, call->id, call->reason, &error);
+
+	isi_call_set_idle(call);
+}
+
+static void isi_call_set_disconnect_reason(struct isi_call *call)
+{
 	enum ofono_disconnect_reason reason;
 =

+	if (call->reason !=3D OFONO_DISCONNECT_REASON_UNKNOWN)
+		return;
+
 	switch (call->status) {
 	case CALL_STATUS_IDLE:
 		reason =3D OFONO_DISCONNECT_REASON_UNKNOWN;
@@ -456,17 +472,9 @@ static void isi_call_release(struct ofono_voicecall *o=
vc, struct isi_call *call)
 	case CALL_STATUS_TERMINATED:
 	default:
 		reason =3D OFONO_DISCONNECT_REASON_ERROR;
-		break;
-	}
-
-	if (!call->reason) {
-		call->reason =3D reason;
-		DBG("disconnected id=3D%u reason=3D%u", call->id, reason);
-		ofono_voicecall_disconnected(ovc, call->id, reason, &error);
 	}
 =

-	if (!reason)
-		isi_call_set_idle(call);
+	call->reason =3D reason;
 }
 =

 static void isi_call_notify(struct ofono_voicecall *ovc, struct isi_call *=
call)
@@ -487,11 +495,20 @@ static void isi_call_notify(struct ofono_voicecall *o=
vc, struct isi_call *call)
 =

 	switch (call->status) {
 	case CALL_STATUS_IDLE:
+		isi_call_disconnected(ovc, call);
+		return;
+
+	case CALL_STATUS_COMING:
+	case CALL_STATUS_PROCEEDING:
+		if ((call->mode_info & CALL_MODE_ORIGINATOR))
+			/* Do not notify early MT calls */
+			return;
+		break;
+
 	case CALL_STATUS_MO_RELEASE:
 	case CALL_STATUS_MT_RELEASE:
 	case CALL_STATUS_TERMINATED:
-		isi_call_release(ovc, call);
-		return;
+		isi_call_set_disconnect_reason(call);
 	}
 =

 	ocall =3D isi_call_as_ofono_call(call);
@@ -615,17 +632,33 @@ static void isi_call_status_ind_cb(const GIsiMessage =
*msg, void *data)
 		}
 	}
 =

-	if (old_status !=3D call->status) {
+	if (old_status =3D=3D call->status)
+		return;
 =

-		if (call->status =3D=3D CALL_STATUS_IDLE) {
-			call->status =3D CALL_STATUS_TERMINATED;
+	isi_call_notify(ovc, call);
+}
 =

-			isi_call_notify(ovc, call);
-			isi_call_set_idle(call);
-			return;
-		}
-	}
+static void isi_call_terminated_ind_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_voicecall *ovc =3D data;
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	struct isi_call *call;
 =

+	uint8_t call_id;
+	uint8_t old_status;
+
+	if (ivc =3D=3D NULL || g_isi_msg_id(msg) !=3D CALL_TERMINATED_IND ||
+			!g_isi_msg_data_get_byte(msg, 0, &call_id) ||
+			(call_id & 7) =3D=3D 0)
+		return;
+
+	call =3D &ivc->calls[call_id & 7];
+	old_status =3D call->status;
+
+	if (old_status =3D=3D CALL_STATUS_IDLE)
+		return;
+
+	call->status =3D CALL_STATUS_TERMINATED;
 	isi_call_notify(ovc, call);
 }
 =

@@ -1255,6 +1288,9 @@ static void isi_call_verify_cb(const GIsiMessage *msg=
, void *data)
 	g_isi_client_ind_subscribe(ivc->client, CALL_STATUS_IND,
 					isi_call_status_ind_cb, ovc);
 =

+	g_isi_client_ind_subscribe(ivc->client, CALL_TERMINATED_IND,
+					isi_call_terminated_ind_cb, ovc);
+
 	if (!isi_call_status_req(ovc, CALL_ID_ALL,
 					CALL_STATUS_MODE_ADDR_AND_ORIGIN,
 					NULL, NULL))
-- =

1.7.1


--===============6782233672762123198==--

