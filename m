Content-Type: multipart/mixed; boundary="===============0219717567194281182=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 2/2] isimodem/voicecall: add long dial string support
Date: Tue, 16 Nov 2010 19:39:49 +0200
Message-ID: <81d6131dedd903a4f7ef9514569d90db8e05b25a.1289928966.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1289928966.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0219717567194281182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/voicecall.c |   83 +++++++++++++++++++++++++++++++++-----=
----
 1 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index c3365f6..b0dad72 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -49,7 +49,7 @@ struct isi_call {
 	uint8_t id, call_id, status, mode, mode_info, cause_type, cause;
 	uint8_t addr_type, presentation;
 	uint8_t reason;
-	char address[20], addr_pad[4];
+	char address[OFONO_MAX_PHONE_NUMBER_LENGTH + 1], addr_pad[4];
 };
 =

 struct isi_voicecall {
@@ -244,6 +244,28 @@ static void isi_call_destination_address_sb_proc(struc=
t isi_voicecall *ivc,
 		isi_call_any_address_sb_proc(ivc, call, sb);
 }
 =

+static void isi_call_destination_post_address_sb_proc(struct isi_voicecall=
 *ivc,
+						struct isi_call *call,
+						GIsiSubBlockIter const *sb)
+{
+	uint8_t addr_info, addr_len;
+	char *address;
+
+	if (!call->address[0] ||
+		strlen(call->address) >=3D OFONO_MAX_PHONE_NUMBER_LENGTH)
+		return;
+
+	if (!g_isi_sb_iter_get_byte(sb, &addr_info, 2) ||
+		!g_isi_sb_iter_get_byte(sb, &addr_len, 3) ||
+		!g_isi_sb_iter_get_alpha_tag(sb, &address, 2 * addr_len, 4))
+		return;
+
+	strncat(call->address, address,
+		OFONO_MAX_PHONE_NUMBER_LENGTH - strlen(call->address));
+	g_free(address);
+
+}
+
 static void isi_call_mode_sb_proc(struct isi_voicecall *ivc,
 					struct isi_call *call,
 					GIsiSubBlockIter const *sb)
@@ -371,40 +393,61 @@ static struct isi_call_req_context *
 isi_call_create_req(struct ofono_voicecall *ovc,
 			uint8_t presentation,
 			uint8_t addr_type,
-			char const address[21],
+			char const address[OFONO_MAX_PHONE_NUMBER_LENGTH + 1],
 			ofono_voicecall_cb_t cb,
 			void *data)
 {
-	size_t addr_len =3D strlen(address);
-	size_t sub_len =3D (6 + 2 * addr_len + 3) & ~3;
-	size_t i, offset =3D 3 + 4 + 8 + 6;
-	uint8_t req[3 + 4 + 8 + 6 + 40] =3D {
+	uint8_t req[3 + 4 + 8 + 10 + 2 * OFONO_MAX_PHONE_NUMBER_LENGTH + 4] =3D {
 		CALL_CREATE_REQ,
 		0,		/* No id */
-		3,		/* Mode, Clir, Number */
+		4,		/* Mode, Clir, Number, Postfix */
 		/* MODE SB */
 		CALL_MODE, 4, CALL_MODE_SPEECH, CALL_MODE_INFO_NONE,
 		/* ORIGIN_INFO SB */
 		CALL_ORIGIN_INFO, 8, presentation, 0, 0, 0, 0, 0,
 		/* DESTINATION_ADDRESS SB */
 		CALL_DESTINATION_ADDRESS,
-		sub_len,
+		0,		/* sub_len */
 		addr_type & 0x7F,
 		0, 0,
-		addr_len,
-		/* uint16_t addr[20] */
+		0,		/* addr_len */
+		/* uint16_t addr[OFONO_MAX_PHONE_NUMBER_LENGTH] */
 	};
-	size_t rlen =3D 3 + 4 + 8 + sub_len;
+	size_t i, j, offset;
 =

-	if (addr_len > 20) {
-		CALLBACK_WITH_FAILURE(cb, data);
-		return NULL;
+	offset =3D 3 + 4 + 8;
+	for (i =3D 0, j =3D 0; address[i]; i++, j++) {
+		if (i > OFONO_MAX_PHONE_NUMBER_LENGTH)
+			goto out;
+		if (address[i] !=3D '*')
+			break;
+		req[offset + 6 + 2 * j + 1] =3D address[i];
 	}
 =

-	for (i =3D 0; i < addr_len; i++)
-		req[offset + 2 * i + 1] =3D address[i];
+	for (; address[i]; i++, j++) {
+		if (i > OFONO_MAX_PHONE_NUMBER_LENGTH)
+			goto out;
+		if (address[i] =3D=3D '*' || address[i] =3D=3D 'p' || address[i] =3D=3D =
'#')
+			break;
+		req[offset + 6 + 2 * j + 1] =3D address[i];
+	}
+	req[offset + 5] =3D j;
+	offset +=3D (req[offset + 1] =3D (6 + 2 * j + 3) & ~3);
+
+	req[offset + 0] =3D CALL_DESTINATION_POST_ADDRESS;
+	for (j =3D 0; address[i]; i++, j++) {
+		if (i > OFONO_MAX_PHONE_NUMBER_LENGTH)
+			goto out;
+		req[offset + 4 + 2 * j + 1] =3D address[i];
+	}
+	req[offset + 3] =3D j;
+	offset +=3D (req[offset + 1] =3D (4 + 2 * j + 3) & ~3);
 =

-	return isi_call_req(ovc, req, rlen, isi_call_create_resp, cb, data);
+	return isi_call_req(ovc, req, offset, isi_call_create_resp, cb, data);
+
+out:
+	CALLBACK_WITH_FAILURE(cb, data);
+	return NULL;
 }
 =

 static gboolean isi_call_create_resp(GIsiClient *client,
@@ -477,13 +520,17 @@ static void isi_call_status_ind_cb(GIsiClient *client,
 			isi_call_destination_address_sb_proc(ivc, call, sb);
 			break;
 =

+		case CALL_DESTINATION_POST_ADDRESS:
+			isi_call_destination_post_address_sb_proc(ivc,
+								call, sb);
+			break;
+
 		case CALL_ORIGIN_ADDRESS:
 			isi_call_origin_address_sb_proc(ivc, call, sb);
 			break;
 =

 		case CALL_GSM_DETAILED_CAUSE:
 		case CALL_DESTINATION_PRE_ADDRESS:
-		case CALL_DESTINATION_POST_ADDRESS:
 		case CALL_DESTINATION_SUBADDRESS:
 		case CALL_GSM_EVENT_INFO:
 		case CALL_NW_CAUSE:
-- =

1.7.0.4


--===============0219717567194281182==--

