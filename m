Content-Type: multipart/mixed; boundary="===============0029059124914217333=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 5/6] Fixed style issues in isimodem voicecall.
Date: Thu, 27 May 2010 19:12:47 +0300
Message-ID: <1274976768-1555-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1274976768-1555-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0029059124914217333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/voicecall.c |   69 +++++++++++++++++++-------------------=
----
 1 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 44ffe96..5c6cc40 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -71,7 +71,7 @@ static struct ofono_call isi_call_as_ofono_call(struct is=
i_call const *);
 static int isi_call_status_to_clcc(struct isi_call const *call);
 static struct isi_call *isi_call_set_idle(struct isi_call *call);
 =

-typedef void GIsiIndication (GIsiClient *client,
+typedef void GIsiIndication(GIsiClient *client,
 		const void *restrict data, size_t len,
 		uint16_t object, void *opaque);
 =

@@ -106,7 +106,7 @@ struct isi_call_req_context {
 =

 static struct isi_call_req_context *
 isi_call_req(struct ofono_voicecall *ovc,
-	     void const * restrict req,
+	     void const *restrict req,
 	     size_t len,
 	     GIsiResponse *handler,
 	     ofono_voicecall_cb_t cb,
@@ -143,10 +143,12 @@ static void isi_ctx_queue(struct isi_call_req_context=
 *irc,
 	if (irc->prev =3D=3D NULL) {
 		struct isi_voicecall *ivc =3D ofono_voicecall_get_data(irc->ovc);
 =

-		irc->prev =3D &ivc->queue;
-		if ((irc->next =3D *irc->prev))
+		if (ivc->queue) {
+			irc->next =3D ivc->queue;
 			irc->next->prev =3D &irc->next;
-		*irc->prev =3D irc;
+		}
+		irc->prev =3D &ivc->queue;
+		ivc->queue =3D irc;
 	}
 =

 	irc->step =3D next;
@@ -155,7 +157,9 @@ static void isi_ctx_queue(struct isi_call_req_context *=
irc,
 static void isi_ctx_remove(struct isi_call_req_context *irc)
 {
 	if (irc->prev) {
-		if ((*irc->prev =3D irc->next)) {
+		*irc->prev =3D irc->next;
+
+		if (irc->next) {
 			irc->next->prev =3D irc->prev;
 			irc->next =3D NULL;
 		}
@@ -285,7 +289,6 @@ static void isi_call_status_sb_proc(struct isi_voicecal=
l *ivc,
 =

 static struct isi_call *
 isi_call_status_info_sb_proc(struct isi_voicecall *ivc,
-			     struct isi_call calls[8],
 			     GIsiSubBlockIter const *sb)
 {
 	struct isi_call *call =3D NULL;
@@ -304,7 +307,7 @@ isi_call_status_info_sb_proc(struct isi_voicecall *ivc,
 	i =3D call_id & 7;
 =

 	if (1 <=3D i && i <=3D 7) {
-		call =3D &calls[i];
+		call =3D &ivc->calls[i];
 		call->call_id =3D call_id;
 		call->status =3D status;
 		call->mode =3D mode;
@@ -316,7 +319,6 @@ isi_call_status_info_sb_proc(struct isi_voicecall *ivc,
 =

 static struct isi_call *
 isi_call_addr_and_status_info_sb_proc(struct isi_voicecall *ivc,
-				      struct isi_call calls[8],
 				      GIsiSubBlockIter const *sb)
 {
 	struct isi_call *call =3D NULL;
@@ -343,7 +345,7 @@ isi_call_addr_and_status_info_sb_proc(struct isi_voicec=
all *ivc,
 	i =3D call_id & 7;
 =

 	if (1 <=3D i && i <=3D 7) {
-		call =3D &calls[i];
+		call =3D &ivc->calls[i];
 		call->call_id =3D call_id;
 		call->status =3D status;
 		call->mode =3D mode;
@@ -433,7 +435,7 @@ static gboolean isi_call_create_resp(GIsiClient *client,
 }
 =

 static void isi_call_status_ind_cb(GIsiClient *client,
-				   void const * restrict data,
+				   void const *restrict data,
 				   size_t len,
 				   uint16_t object,
 				   void *_ovc)
@@ -641,11 +643,11 @@ static gboolean isi_call_status_resp(GIsiClient *clie=
nt,
 		switch (g_isi_sb_iter_get_id(sb)) {
 =

 		case CALL_STATUS_INFO:
-			call =3D isi_call_status_info_sb_proc(ivc, ivc->calls, sb);
+			call =3D isi_call_status_info_sb_proc(ivc, sb);
 			break;
 =

 		case CALL_ADDR_AND_STATUS_INFO:
-			call =3D isi_call_addr_and_status_info_sb_proc(ivc, ivc->calls, sb);
+			call =3D isi_call_addr_and_status_info_sb_proc(ivc, sb);
 			if (call)
 				isi_call_notify(ovc, call);
 			break;
@@ -965,7 +967,7 @@ static struct isi_call *isi_call_set_idle(struct isi_ca=
ll *call)
 /* ---------------------------------------------------------------------- =
*/
 =

 static void isi_dial(struct ofono_voicecall *ovc,
-		     const struct ofono_phone_number * restrict number,
+		     const struct ofono_phone_number *restrict number,
 		     enum ofono_clir_option clir,
 		     enum ofono_cug_option cug,
 		     ofono_voicecall_cb_t cb,
@@ -973,8 +975,7 @@ static void isi_dial(struct ofono_voicecall *ovc,
 {
 	unsigned char presentation =3D CALL_GSM_PRESENTATION_DEFAULT;
 =

-	switch (clir)
-	{
+	switch (clir) {
 	case OFONO_CLIR_OPTION_DEFAULT:
 		presentation =3D CALL_GSM_PRESENTATION_DEFAULT;
 		break;
@@ -986,8 +987,7 @@ static void isi_dial(struct ofono_voicecall *ovc,
 		break;
 	}
 =

-	switch (cug)
-	{
+	switch (cug) {
 	case OFONO_CUG_OPTION_DEFAULT:
 		break;
 	case OFONO_CUG_OPTION_INVOCATION:
@@ -1092,8 +1092,7 @@ static void isi_release_all_active(struct ofono_voice=
call *ovc,
 			isi_ctx_queue(irc, isi_wait_and_answer);
 		else if (hold)
 			isi_ctx_queue(irc, isi_wait_and_retrieve);
-	}
-	else
+	} else
 		CALLBACK_WITH_FAILURE(cb, data);
 }
 =

@@ -1139,21 +1138,19 @@ static void isi_hold_all_active(struct ofono_voicec=
all *ovc,
 =

 	if (waiting) {
 		isi_call_answer_req(ovc, CALL_ID_WAITING, cb, data);
-	}
-	else if (hold) {
+	} else if (hold) {
 		if (active) {
-			id =3D CALL_ID_ACTIVE, op =3D CALL_OP_SWAP;
-		}
-		else {
-			id =3D CALL_ID_HOLD, op =3D CALL_OP_RETRIEVE;
+			op =3D CALL_OP_SWAP;
+			id =3D CALL_ID_ACTIVE;
+		} else {
+			op =3D CALL_OP_RETRIEVE;
+			id =3D CALL_ID_HOLD;
 		}
 		isi_call_control_req(ovc, id, op, 0, cb, data);
-	}
-	else if (active) {
+	} else if (active) {
 		id =3D CALL_ID_ACTIVE, op =3D CALL_OP_HOLD;
 		isi_call_control_req(ovc, id, op, 0, cb, data);
-	}
-	else {
+	} else {
 		CALLBACK_WITH_FAILURE(cb, data);
 	}
 }
@@ -1182,8 +1179,7 @@ static void isi_release_specific(struct ofono_voiceca=
ll *ovc, int id,
 		isi_call_release_req(ovc, id,
 				     CALL_CAUSE_TYPE_CLIENT, cause,
 				     cb, data);
-	}
-	else
+	} else
 		CALLBACK_WITH_FAILURE(cb, data);
 }
 =

@@ -1252,14 +1248,11 @@ static void isi_swap_without_accept(struct ofono_vo=
icecall *ovc,
 =

 	if (hold && active) {
 		id =3D CALL_ID_ACTIVE, op =3D CALL_OP_SWAP;
-	}
-	else if (active) {
+	} else if (active) {
 		id =3D CALL_ID_ACTIVE, op =3D CALL_OP_HOLD;
-	}
-	else if (hold) {
+	} else if (hold) {
 		id =3D CALL_ID_HOLD, op =3D CALL_OP_RETRIEVE;
-	}
-	else {
+	} else {
 		CALLBACK_WITH_FAILURE(cb, data);
 		return;
 	}
-- =

1.6.3.3


--===============0029059124914217333==--

