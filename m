Content-Type: multipart/mixed; boundary="===============0791027649309357183=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isi-voicecall-fix PATCHv3 2/6] isi/voicecall: fix  status reporting
Date: Tue, 16 Nov 2010 19:05:20 +0200
Message-ID: <1289927124-30133-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1289927124-30133-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0791027649309357183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Report early incoming calls as waiting or incoming, depending on the
state of other calls.

Report MT_RELEASED or MO_RELEASED via ofono_voicecall_notify(),
TERMINATED calls via ofono_voicecall_disconnected().
---
 drivers/isimodem/voicecall.c |  401 +++++++++++++++++++++-----------------=
----
 1 files changed, 203 insertions(+), 198 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index c3365f6..c450f12 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -62,13 +62,6 @@ struct isi_voicecall {
 =

 /* -----------------------------------------------------------------------=
-- */
 =

-static void isi_call_notify(struct ofono_voicecall *ovc,
-				struct isi_call *call);
-static void isi_call_release(struct ofono_voicecall *, struct isi_call *);
-static struct ofono_call isi_call_as_ofono_call(struct isi_call const *);
-static int isi_call_status_to_clcc(struct isi_call const *call);
-static struct isi_call *isi_call_set_idle(struct isi_call *call);
-
 typedef void GIsiIndication(GIsiClient *client,
 		const void *restrict data, size_t len,
 		uint16_t object, void *opaque);
@@ -80,9 +73,6 @@ typedef gboolean GIsiResponse(GIsiClient *client,
 				void const *restrict data, size_t len,
 				uint16_t object, void *opaque);
 =

-static GIsiVerify isi_call_verify_cb;
-static gboolean isi_call_register(gpointer);
-
 enum {
 	ISI_CALL_TIMEOUT =3D 1000,
 };
@@ -205,6 +195,174 @@ static gboolean isi_ctx_return_success(struct isi_cal=
l_req_context *irc)
 }
 =

 /* -----------------------------------------------------------------------=
-- */
+/* Notify */
+
+enum clcc_status {
+	CLCC_STATUS_ACTIVE =3D 0,
+	CLCC_STATUS_HOLD =3D 1,
+	CLCC_STATUS_DIALING =3D 2,
+	CLCC_STATUS_ALERTING =3D 3,
+	CLCC_STATUS_INCOMING =3D 4,
+	CLCC_STATUS_WAITING =3D 5,
+	CLCC_STATUS_DISCONNECTED =3D 6, /* Nonstandard */
+};
+
+static int isi_call_waiting_or_incoming(struct isi_voicecall const *ivc)
+{
+	int id;
+
+	for (id =3D 1; id <=3D 7; id++) {
+		switch (ivc->calls[id].status) {
+		case CALL_STATUS_ANSWERED:
+		case CALL_STATUS_ACTIVE:
+		case CALL_STATUS_HOLD_INITIATED:
+		case CALL_STATUS_HOLD:
+		case CALL_STATUS_RETRIEVE_INITIATED:
+		case CALL_STATUS_RECONNECT_PENDING:
+		case CALL_STATUS_SWAP_INITIATED:
+			return CLCC_STATUS_WAITING;
+		}
+	}
+
+	return CLCC_STATUS_INCOMING;
+}
+
+/** Get +CLCC status */
+static int isi_call_status_to_clcc(struct isi_voicecall const *ivc,
+					struct isi_call const *call)
+{
+	switch (call->status) {
+	case CALL_STATUS_CREATE:
+		return CLCC_STATUS_DIALING;
+
+	case CALL_STATUS_COMING:
+		return isi_call_waiting_or_incoming(ivc);
+
+	case CALL_STATUS_PROCEEDING:
+		if ((call->mode_info & CALL_MODE_ORIGINATOR))
+			return isi_call_waiting_or_incoming(ivc); /* MT */
+		else
+			return CLCC_STATUS_DIALING; /* MO */
+
+	case CALL_STATUS_MO_ALERTING:
+		return CLCC_STATUS_ALERTING;
+
+	case CALL_STATUS_MT_ALERTING:
+		return CLCC_STATUS_INCOMING;
+
+	case CALL_STATUS_WAITING:
+		return CLCC_STATUS_WAITING;
+
+	case CALL_STATUS_ANSWERED:
+	case CALL_STATUS_ACTIVE:
+	case CALL_STATUS_HOLD_INITIATED:
+	case CALL_STATUS_RECONNECT_PENDING:
+	case CALL_STATUS_SWAP_INITIATED:
+		return CLCC_STATUS_ACTIVE;
+
+	case CALL_STATUS_HOLD:
+	case CALL_STATUS_RETRIEVE_INITIATED:
+		return CLCC_STATUS_HOLD;
+
+	case CALL_STATUS_MO_RELEASE:
+	case CALL_STATUS_MT_RELEASE:
+	case CALL_STATUS_TERMINATED:
+	case CALL_STATUS_IDLE:
+		return CLCC_STATUS_DISCONNECTED;
+	}
+
+	return CLCC_STATUS_ACTIVE;
+}
+
+static struct ofono_call isi_call_as_ofono_call(struct isi_voicecall const=
 *ivc,
+						struct isi_call const *call)
+{
+	struct ofono_call ocall =3D { call->id };
+	struct ofono_phone_number *number =3D &ocall.phone_number;
+
+	ocall.type =3D 0;	/* Voice call */
+	ocall.direction =3D call->mode_info & CALL_MODE_ORIGINATOR;
+	ocall.status =3D isi_call_status_to_clcc(ivc, call);
+	memcpy(number->number, call->address, sizeof number->number);
+	number->type =3D 0x80 | call->addr_type;
+	ocall.clip_validity =3D call->presentation & 3;
+
+	if (ocall.clip_validity =3D=3D 0 && strlen(number->number) =3D=3D 0)
+		ocall.clip_validity =3D 2;
+
+	return ocall;
+}
+
+static struct isi_call *isi_call_set_idle(struct isi_call *call)
+{
+	uint8_t id;
+
+	id =3D call->id;
+	memset(call, 0, sizeof *call);
+	call->id =3D id;
+
+	return call;
+}
+
+static void isi_call_disconnected(struct ofono_voicecall *ovc,
+					struct isi_call *call)
+{
+	struct ofono_error error =3D { OFONO_ERROR_TYPE_NO_ERROR, 0 };
+	enum ofono_disconnect_reason reason =3D call->reason;
+
+	if (!reason)
+		reason =3D OFONO_DISCONNECT_REASON_ERROR;
+
+	DBG("disconnected id=3D%u reason=3D%u", call->id, reason);
+	ofono_voicecall_disconnected(ovc, call->id, reason, &error);
+	isi_call_set_idle(call);
+}
+
+static void isi_call_notify(struct ofono_voicecall *ovc,
+				struct isi_call *call)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	struct isi_call_req_context *irc, **queue;
+	struct ofono_call ocall;
+
+	DBG("called with status=3D%s (0x%02X)",
+		call_status_name(call->status), call->status);
+
+	for (queue =3D &ivc->queue; (irc =3D *queue);) {
+		irc->step(irc, call->status);
+
+		if (*queue =3D=3D irc)
+			queue =3D &irc->next;
+	}
+
+	ocall =3D isi_call_as_ofono_call(ivc, call);
+
+	DBG("id=3D%u,\"%s\",%u,\"%s\",%u,%u",
+		ocall.id,
+		ocall.direction ? "mt" : "mo",
+		ocall.status,
+		ocall.phone_number.number,
+		ocall.phone_number.type,
+		ocall.clip_validity);
+
+	ofono_voicecall_notify(ovc, &ocall);
+
+	switch (call->status) {
+	case CALL_STATUS_MO_RELEASE:
+		call->reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
+		break;
+
+	case CALL_STATUS_MT_RELEASE:
+		call->reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+		break;
+
+	case CALL_STATUS_IDLE:
+	case CALL_STATUS_TERMINATED:
+		isi_call_disconnected(ovc, call);
+	}
+}
+
+/* -----------------------------------------------------------------------=
-- */
 /* Decoding subblocks */
 =

 static void isi_call_any_address_sb_proc(struct isi_voicecall *ivc,
@@ -491,16 +649,8 @@ static void isi_call_status_ind_cb(GIsiClient *client,
 		}
 	}
 =

-	if (old !=3D call->status) {
-		if (call->status =3D=3D CALL_STATUS_IDLE) {
-			call->status =3D CALL_STATUS_TERMINATED;
-			isi_call_notify(ovc, call);
-			isi_call_set_idle(call);
-			return;
-		}
-	}
-
-	isi_call_notify(ovc, call);
+	if (old !=3D call->status)
+		isi_call_notify(ovc, call);
 }
 =

 static struct isi_call_req_context *
@@ -801,150 +951,6 @@ static gboolean isi_call_dtmf_send_resp(GIsiClient *c=
lient,
 		return isi_ctx_return_failure(irc);
 }
 =

-
-/* -----------------------------------------------------------------------=
-- */
-/* Notify */
-
-static void isi_call_notify(struct ofono_voicecall *ovc,
-				struct isi_call *call)
-{
-	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
-	struct isi_call_req_context *irc, **queue;
-	struct ofono_call ocall;
-
-	DBG("called with status=3D%s (0x%02X)",
-		call_status_name(call->status), call->status);
-
-	for (queue =3D &ivc->queue; (irc =3D *queue);) {
-		irc->step(irc, call->status);
-		if (*queue =3D=3D irc)
-			queue =3D &irc->next;
-	}
-
-	switch (call->status) {
-	case CALL_STATUS_IDLE:
-	case CALL_STATUS_MO_RELEASE:
-	case CALL_STATUS_MT_RELEASE:
-	case CALL_STATUS_TERMINATED:
-		isi_call_release(ovc, call);
-		return;
-	}
-
-	ocall =3D isi_call_as_ofono_call(call);
-
-	DBG("id=3D%u,%s,%u,\"%s\",%u,%u",
-		ocall.id,
-		ocall.direction ? "terminated" : "originated",
-		ocall.status,
-		ocall.phone_number.number,
-		ocall.phone_number.type,
-		ocall.clip_validity);
-
-	ofono_voicecall_notify(ovc, &ocall);
-}
-
-static void isi_call_release(struct ofono_voicecall *ovc,
-				struct isi_call *call)
-{
-	struct ofono_error error =3D { OFONO_ERROR_TYPE_NO_ERROR, 0 };
-	enum ofono_disconnect_reason reason;
-
-	switch (call->status) {
-	case CALL_STATUS_IDLE:
-		reason =3D OFONO_DISCONNECT_REASON_UNKNOWN;
-		break;
-	case CALL_STATUS_MO_RELEASE:
-		reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
-		break;
-	case CALL_STATUS_MT_RELEASE:
-		reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
-		break;
-	case CALL_STATUS_TERMINATED:
-	default:
-		reason =3D OFONO_DISCONNECT_REASON_ERROR;
-		break;
-	}
-
-	if (!call->reason) {
-		call->reason =3D reason;
-		DBG("disconnected id=3D%u reason=3D%u", call->id, reason);
-		ofono_voicecall_disconnected(ovc, call->id, reason, &error);
-	}
-
-	if (!reason)
-		isi_call_set_idle(call);
-}
-
-static struct ofono_call isi_call_as_ofono_call(struct isi_call const *cal=
l)
-{
-	struct ofono_call ocall =3D { call->id };
-	struct ofono_phone_number *number =3D &ocall.phone_number;
-
-	ocall.type =3D 0;	/* Voice call */
-	ocall.direction =3D call->mode_info & CALL_MODE_ORIGINATOR;
-	ocall.status =3D isi_call_status_to_clcc(call);
-	memcpy(number->number, call->address, sizeof number->number);
-	number->type =3D 0x80 | call->addr_type;
-	ocall.clip_validity =3D call->presentation & 3;
-	if (ocall.clip_validity =3D=3D 0 && strlen(number->number) =3D=3D 0)
-		ocall.clip_validity =3D 2;
-
-	return ocall;
-}
-
-/** Get +CLCC status */
-static int isi_call_status_to_clcc(struct isi_call const *call)
-{
-	switch (call->status) {
-	case CALL_STATUS_CREATE:
-		return 2;
-	case CALL_STATUS_COMING:
-		return 4;
-	case CALL_STATUS_PROCEEDING:
-		if ((call->mode_info & CALL_MODE_ORIGINATOR))
-			return 4; /* MT */
-		else
-			return 2; /* MO */
-	case CALL_STATUS_MO_ALERTING:
-		return 3;
-	case CALL_STATUS_MT_ALERTING:
-		return 4;
-	case CALL_STATUS_WAITING:
-		return 5;
-
-	case CALL_STATUS_ANSWERED:
-	case CALL_STATUS_ACTIVE:
-	case CALL_STATUS_MO_RELEASE:
-	case CALL_STATUS_MT_RELEASE:
-	case CALL_STATUS_HOLD_INITIATED:
-		return 0;
-
-	case CALL_STATUS_HOLD:
-	case CALL_STATUS_RETRIEVE_INITIATED:
-		return 1;
-
-	case CALL_STATUS_RECONNECT_PENDING:
-	case CALL_STATUS_TERMINATED:
-	case CALL_STATUS_SWAP_INITIATED:
-		return 0;
-	}
-
-	return 0;
-}
-
-static struct isi_call *isi_call_set_idle(struct isi_call *call)
-{
-	uint8_t id;
-
-	if (call) {
-		id =3D call->id;
-		memset(call, 0, sizeof *call);
-		call->id =3D id;
-	}
-
-	return call;
-}
-
 /* ---------------------------------------------------------------------- =
*/
 =

 static void isi_dial(struct ofono_voicecall *ovc,
@@ -1244,31 +1250,27 @@ static void isi_send_tones(struct ofono_voicecall *=
ovc, const char *tones,
 	isi_call_dtmf_send_req(ovc, CALL_ID_ALL, tones, cb, data);;
 }
 =

-static int isi_voicecall_probe(struct ofono_voicecall *ovc,
-				unsigned int vendor, void *user)
+static gboolean isi_call_register(gpointer _ovc)
 {
-	GIsiModem *idx =3D user;
-	struct isi_voicecall *ivc =3D g_try_new0(struct isi_voicecall, 1);
-	int id;
-
-	if (!ivc)
-		return -ENOMEM;
+	struct ofono_voicecall *ovc =3D _ovc;
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	const char *debug =3D getenv("OFONO_ISI_DEBUG");
 =

-	for (id =3D 0; id <=3D 7; id++)
-		ivc->calls[id].id =3D id;
+	if (debug && (strcmp(debug, "all") =3D=3D 0 || strcmp(debug, "call") =3D=
=3D 0))
+		g_isi_client_set_debug(ivc->client, call_debug, NULL);
 =

-	ivc->client =3D g_isi_client_create(idx, PN_CALL);
-	if (!ivc->client) {
-		g_free(ivc);
-		return -ENOMEM;
-	}
+	g_isi_subscribe(ivc->client,
+			CALL_STATUS_IND, isi_call_status_ind_cb,
+			ovc);
 =

-	ofono_voicecall_set_data(ovc, ivc);
+	if (!isi_call_status_req(ovc, CALL_ID_ALL,
+					CALL_STATUS_MODE_ADDR_AND_ORIGIN,
+					NULL, NULL))
+		DBG("Failed to request call status");
 =

-	if (!g_isi_verify(ivc->client, isi_call_verify_cb, ovc))
-		DBG("Unable to verify reachability");
+	ofono_voicecall_register(ovc);
 =

-	return 0;
+	return FALSE;
 }
 =

 static void isi_call_verify_cb(GIsiClient *client,
@@ -1287,28 +1289,31 @@ static void isi_call_verify_cb(GIsiClient *client,
 	g_idle_add(isi_call_register, ovc);
 }
 =

-static gboolean isi_call_register(gpointer _ovc)
+static int isi_voicecall_probe(struct ofono_voicecall *ovc,
+				unsigned int vendor, void *user)
 {
-	struct ofono_voicecall *ovc =3D _ovc;
-	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	GIsiModem *idx =3D user;
+	struct isi_voicecall *ivc =3D g_try_new0(struct isi_voicecall, 1);
+	int id;
 =

-	const char *debug =3D getenv("OFONO_ISI_DEBUG");
+	if (!ivc)
+		return -ENOMEM;
 =

-	if (debug && (strcmp(debug, "all") =3D=3D 0 || strcmp(debug, "call") =3D=
=3D 0))
-		g_isi_client_set_debug(ivc->client, call_debug, NULL);
+	for (id =3D 1; id <=3D 7; id++)
+		ivc->calls[id].id =3D id;
 =

-	g_isi_subscribe(ivc->client,
-			CALL_STATUS_IND, isi_call_status_ind_cb,
-			ovc);
+	ivc->client =3D g_isi_client_create(idx, PN_CALL);
+	if (!ivc->client) {
+		g_free(ivc);
+		return -ENOMEM;
+	}
 =

-	if (!isi_call_status_req(ovc, CALL_ID_ALL,
-					CALL_STATUS_MODE_ADDR_AND_ORIGIN,
-					NULL, NULL))
-		DBG("Failed to request call status");
+	ofono_voicecall_set_data(ovc, ivc);
 =

-	ofono_voicecall_register(ovc);
+	if (!g_isi_verify(ivc->client, isi_call_verify_cb, ovc))
+		DBG("Unable to verify reachability");
 =

-	return FALSE;
+	return 0;
 }
 =

 static void isi_voicecall_remove(struct ofono_voicecall *call)
-- =

1.7.1


--===============0791027649309357183==--

