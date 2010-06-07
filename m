Content-Type: multipart/mixed; boundary="===============6445518961864800561=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/20] Make stk_pdu_from_response use static buffers
Date: Mon, 07 Jun 2010 12:08:23 +0200
Message-ID: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6445518961864800561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c       |   36 ++++++++++++++++++++----------------
 src/stkutil.h       |    5 ++---
 unit/test-stkutil.c |   15 ++++++++++-----
 3 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 82d4e84..14958a8 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3980,14 +3980,15 @@ static gboolean build_local_info(struct stk_tlv_bui=
lder *builder,
 	return FALSE;
 }
 =

-unsigned int stk_pdu_from_response(const struct stk_response *response,
-					unsigned char *pdu, unsigned int size)
+const unsigned char *stk_pdu_from_response(const struct stk_response *resp=
onse,
+						unsigned int *out_length)
 {
 	struct stk_tlv_builder builder;
 	gboolean ok =3D TRUE;
 	unsigned char tag;
+	static unsigned char pdu[512];
 =

-	stk_tlv_builder_init(&builder, pdu, size);
+	stk_tlv_builder_init(&builder, pdu, sizeof(pdu));
 =

 	/*
 	 * Encode command details, they come in order with
@@ -3996,19 +3997,19 @@ unsigned int stk_pdu_from_response(const struct stk=
_response *response,
 	 */
 	tag =3D STK_DATA_OBJECT_TYPE_COMMAND_DETAILS;
 	if (stk_tlv_builder_open_container(&builder, TRUE, tag, FALSE) =3D=3D FAL=
SE)
-		return 0;
+		return NULL;
 =

 	if (stk_tlv_builder_append_byte(&builder, response->number) =3D=3D FALSE)
-		return 0;
+		return NULL;
 =

 	if (stk_tlv_builder_append_byte(&builder, response->type) =3D=3D FALSE)
-		return 0;
+		return NULL;
 =

 	if (stk_tlv_builder_append_byte(&builder, response->qualifier) =3D=3D FAL=
SE)
-		return 0;
+		return NULL;
 =

 	if (stk_tlv_builder_close_container(&builder) =3D=3D FALSE)
-		return 0;
+		return NULL;
 =

 	/* TS 102 223 section 6.8 states:
 	 * "For all COMPREHENSION-TLV objects with Min =3D N, the terminal
@@ -4022,19 +4023,19 @@ unsigned int stk_pdu_from_response(const struct stk=
_response *response,
 	 */
 	tag =3D STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES;
 	if (stk_tlv_builder_open_container(&builder, TRUE, tag, FALSE) =3D=3D FAL=
SE)
-		return 0;
+		return NULL;
 =

 	if (stk_tlv_builder_append_byte(&builder, response->src) =3D=3D FALSE)
-		return 0;
+		return NULL;
 =

 	if (stk_tlv_builder_append_byte(&builder, response->dst) =3D=3D FALSE)
-		return 0;
+		return NULL;
 =

 	if (stk_tlv_builder_close_container(&builder) =3D=3D FALSE)
-		return 0;
+		return NULL;
 =

 	if (build_dataobj_result(&builder, &response->result, TRUE) !=3D TRUE)
-		return 0;
+		return NULL;
 =

 	switch (response->type) {
 	case STK_COMMAND_TYPE_DISPLAY_TEXT:
@@ -4105,11 +4106,14 @@ unsigned int stk_pdu_from_response(const struct stk=
_response *response,
 	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
 		break;
 	default:
-		return 0;
+		return NULL;
 	};
 =

 	if (ok !=3D TRUE)
-		return 0;
+		return NULL;
+
+	if (out_length)
+		*out_length =3D stk_tlv_builder_get_length(&builder);
 =

-	return stk_tlv_builder_get_length(&builder);
+	return pdu;
 }
diff --git a/src/stkutil.h b/src/stkutil.h
index cc5801c..7dd0d6c 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1176,6 +1176,5 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 						unsigned int len);
 void stk_command_free(struct stk_command *command);
 =

-/* Returns # of bytes written or zero on error */
-unsigned int stk_pdu_from_response(const struct stk_response *response,
-					unsigned char *pdu, unsigned int size);
+const unsigned char *stk_pdu_from_response(const struct stk_response *resp=
onse,
+						unsigned int *out_length);
diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index fb354bd..eb50d17 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -13949,13 +13949,18 @@ struct terminal_response_test {
 static void test_terminal_response_encoding(gconstpointer data)
 {
 	const struct terminal_response_test *test =3D data;
-	unsigned char buf[512];
-	unsigned int len;
+	const unsigned char *pdu;
+	unsigned int pdu_len;
 =

-	len =3D stk_pdu_from_response(&test->response, buf, sizeof(buf));
+	pdu =3D stk_pdu_from_response(&test->response, &pdu_len);
+
+	if (test->pdu)
+		g_assert(pdu);
+	else
+		g_assert(pdu =3D=3D NULL);
 =

-	g_assert(len =3D=3D test->pdu_len);
-	g_assert(memcmp(buf, test->pdu, len) =3D=3D 0);
+	g_assert(pdu_len =3D=3D test->pdu_len);
+	g_assert(memcmp(pdu, test->pdu, pdu_len) =3D=3D 0);
 }
 =

 static const unsigned char display_text_response_111[] =3D {
-- =

1.7.1.86.g0e460.dirty


--===============6445518961864800561==--

