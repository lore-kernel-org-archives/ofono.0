Content-Type: multipart/mixed; boundary="===============1348475568643303579=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 3/6] Eliminated bool, true and false from gisi.
Date: Thu, 27 May 2010 19:12:45 +0300
Message-ID: <1274976768-1555-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1274976768-1555-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1348475568643303579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gisi/client.c  |   10 +------
 gisi/client.h  |   17 ++++++-------
 gisi/iter.c    |   73 +++++++++++++++++++++++++++-------------------------=
---
 gisi/iter.h    |   23 ++++++++---------
 gisi/netlink.c |    1 -
 gisi/netlink.h |    1 -
 gisi/pipe.c    |   45 +++++++++++++++++-----------------
 gisi/server.h  |    7 ++---
 gisi/verify.c  |   13 ++++-----
 9 files changed, 88 insertions(+), 102 deletions(-)

diff --git a/gisi/client.c b/gisi/client.c
index fa40f0c..640484d 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -570,14 +570,8 @@ static void g_isi_dispatch_response(GIsiClient *client=
, uint16_t obj,
 =

 	req =3D *(GIsiRequest **)ret;
 =

-	if (req->func) {
-		bool handled;
-
-		handled =3D req->func(client, msg + 1, len - 1, obj, req->data);
-		if (!handled)
-			return;
-	}
-	g_isi_request_cancel(req);
+	if (!req->func || req->func(client, msg + 1, len - 1, obj, req->data))
+		g_isi_request_cancel(req);
 }
 =

 /* Data callback for both responses and indications */
diff --git a/gisi/client.h b/gisi/client.h
index 1962f5c..7046f31 100644
--- a/gisi/client.h
+++ b/gisi/client.h
@@ -27,7 +27,6 @@ extern "C" {
 #endif
 =

 #include <stdint.h>
-#include <stdbool.h>
 #include <gisi/modem.h>
 =

 struct _GIsiClient;
@@ -36,16 +35,16 @@ typedef struct _GIsiClient GIsiClient;
 struct _GIsiRequest;
 typedef struct _GIsiRequest GIsiRequest;
 =

-typedef void (*GIsiVerifyFunc)(GIsiClient *client, bool alive,
+typedef void (*GIsiVerifyFunc)(GIsiClient *client, gboolean alive,
 				uint16_t object, void *opaque);
 =

-typedef bool (*GIsiResponseFunc)(GIsiClient *client,
-		const void *restrict data, size_t len,
-		uint16_t object, void *opaque);
+typedef gboolean (*GIsiResponseFunc)(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque);
 =

 typedef void (*GIsiIndicationFunc) (GIsiClient *client,
-		const void *restrict data, size_t len,
-		uint16_t object, void *opaque);
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque);
 =

 GIsiClient *g_isi_client_create(GIsiModem *modem, uint8_t resource);
 =

@@ -70,8 +69,8 @@ GIsiRequest *g_isi_request_make(GIsiClient *client, const=
 void *data,
 				GIsiResponseFunc func, void *opaque);
 struct iovec;
 GIsiRequest *g_isi_request_vmake(GIsiClient *client, const struct iovec *i=
ov,
-				size_t iovlen, unsigned timeout,
-				GIsiResponseFunc func, void *opaque);
+					size_t iovlen, unsigned timeout,
+					GIsiResponseFunc func, void *opaque);
 =

 void g_isi_request_cancel(GIsiRequest *req);
 =

diff --git a/gisi/iter.c b/gisi/iter.c
index 152b236..7b3191b 100644
--- a/gisi/iter.c
+++ b/gisi/iter.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 =

-#include <stdbool.h>
 #include <stdint.h>
 #include <string.h>
 #include <glib.h>
@@ -49,7 +48,7 @@ static inline void bcd_to_mccmnc(const uint8_t *restrict =
bcd,
 }
 =

 void g_isi_sb_iter_init_full(GIsiSubBlockIter *iter, const void *restrict =
data,
-				size_t len, size_t used, bool longhdr,
+				size_t len, size_t used, gboolean longhdr,
 				uint16_t sub_blocks)
 {
 	if (!data)
@@ -69,25 +68,25 @@ void g_isi_sb_iter_init(GIsiSubBlockIter *iter, const v=
oid *restrict data,
 =

 	iter->start =3D (uint8_t *)data + used;
 	iter->end =3D iter->start + len;
-	iter->longhdr =3D false;
+	iter->longhdr =3D FALSE;
 	iter->sub_blocks =3D len > used ? iter->start[-1] : 0;
 }
 =

-bool g_isi_sb_iter_is_valid(const GIsiSubBlockIter *iter)
+gboolean g_isi_sb_iter_is_valid(const GIsiSubBlockIter *iter)
 {
 	if (!iter)
-		return false;
+		return FALSE;
 =

 	if (iter->sub_blocks =3D=3D 0)
-		return false;
+		return FALSE;
 =

 	if (iter->start + (iter->longhdr ? 4 : 2) > iter->end)
-		return false;
+		return FALSE;
 =

 	if (iter->start + g_isi_sb_iter_get_len(iter) > iter->end)
-		return false;
+		return FALSE;
 =

-	return true;
+	return TRUE;
 }
 =

 int g_isi_sb_iter_get_id(const GIsiSubBlockIter *iter)
@@ -104,103 +103,103 @@ size_t g_isi_sb_iter_get_len(const GIsiSubBlockIter=
 *iter)
 	return iter->start[1];
 }
 =

-bool g_isi_sb_iter_get_data(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_data(const GIsiSubBlockIter *restrict iter,
 				void **data, unsigned pos)
 {
 	if ((size_t)pos > g_isi_sb_iter_get_len(iter)
 		|| iter->start + pos > iter->end)
-		return false;
+		return FALSE;
 	*data =3D (void *)iter->start + pos;
-	return true;
+	return TRUE;
 }
 =

-bool g_isi_sb_iter_get_byte(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_byte(const GIsiSubBlockIter *restrict iter,
 				uint8_t *byte, unsigned pos)
 {
 	if ((size_t)pos > g_isi_sb_iter_get_len(iter)
 		|| iter->start + pos > iter->end)
-		return false;
+		return FALSE;
 	*byte =3D iter->start[pos];
-	return true;
+	return TRUE;
 }
 =

-bool g_isi_sb_iter_get_word(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_word(const GIsiSubBlockIter *restrict iter,
 				uint16_t *word, unsigned pos)
 {
 	uint16_t val;
 =

 	if (pos + 1 > g_isi_sb_iter_get_len(iter))
-		return false;
+		return FALSE;
 =

 	memcpy(&val, iter->start + pos, sizeof(uint16_t));
 	*word =3D ntohs(val);
-	return true;
+	return TRUE;
 }
 =

-bool g_isi_sb_iter_get_dword(const GIsiSubBlockIter *restrict iter,
-				uint32_t *dword, unsigned pos)
+gboolean g_isi_sb_iter_get_dword(const GIsiSubBlockIter *restrict iter,
+					uint32_t *dword, unsigned pos)
 {
 	uint32_t val;
 =

 	if (pos + 3 > g_isi_sb_iter_get_len(iter))
-		return false;
+		return FALSE;
 =

 	memcpy(&val, iter->start + pos, sizeof(uint32_t));
 	*dword =3D ntohl(val);
-	return true;
+	return TRUE;
 }
 =

-bool g_isi_sb_iter_get_oper_code(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_oper_code(const GIsiSubBlockIter *restrict iter,
 					char *mcc, char *mnc, unsigned pos)
 {
 	if (pos + 2 > g_isi_sb_iter_get_len(iter))
-		return false;
+		return FALSE;
 =

 	bcd_to_mccmnc(iter->start + pos, mcc, mnc);
-	return true;
+	return TRUE;
 }
 =

-bool g_isi_sb_iter_get_alpha_tag(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_alpha_tag(const GIsiSubBlockIter *restrict iter,
 					char **utf8, size_t len, unsigned pos)
 {
 	uint8_t *ucs2 =3D NULL;
 =

 	if (pos > g_isi_sb_iter_get_len(iter))
-		return false;
+		return FALSE;
 =

 	if (!utf8 || len =3D=3D 0 || pos + len > g_isi_sb_iter_get_len(iter))
-		return false;
+		return FALSE;
 =

 	ucs2 =3D iter->start + pos;
 	if (ucs2 + len > iter->end)
-		return false;
+		return FALSE;
 =

 	*utf8 =3D g_convert((const char *)ucs2, len, "UTF-8//TRANSLIT", "UCS-2BE",
 				NULL, NULL, NULL);
 	return *utf8 !=3D NULL;
 }
 =

-bool g_isi_sb_iter_get_latin_tag(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_latin_tag(const GIsiSubBlockIter *restrict iter,
 					char **latin, size_t len, unsigned pos)
 {
 	uint8_t *str =3D NULL;
 =

 	if (pos > g_isi_sb_iter_get_len(iter))
-		return false;
+		return FALSE;
 =

 	if (!latin || len =3D=3D 0 || pos + len > g_isi_sb_iter_get_len(iter))
-		return false;
+		return FALSE;
 =

 	str =3D iter->start + pos;
 	if (str + len > iter->end)
-		return false;
+		return FALSE;
 =

 	*latin =3D g_strndup((char *)str, len);
 =

 	return *latin !=3D NULL;
 }
 =

-bool g_isi_sb_iter_next(GIsiSubBlockIter *iter)
+gboolean g_isi_sb_iter_next(GIsiSubBlockIter *iter)
 {
 	uint8_t len =3D g_isi_sb_iter_get_len(iter);
 =

@@ -208,13 +207,13 @@ bool g_isi_sb_iter_next(GIsiSubBlockIter *iter)
 		len =3D iter->longhdr ? 4 : 2;
 =

 	if (iter->sub_blocks =3D=3D 0)
-		return false;
+		return FALSE;
 =

 	if (iter->start + len > iter->end)
-		return false;
+		return FALSE;
 =

 	iter->start +=3D len;
 	iter->sub_blocks--;
 =

-	return true;
+	return TRUE;
 }
diff --git a/gisi/iter.h b/gisi/iter.h
index 8648900..8418331 100644
--- a/gisi/iter.h
+++ b/gisi/iter.h
@@ -29,7 +29,6 @@ extern "C" {
 #endif
 =

 #include <stdint.h>
-#include <stdbool.h>
 =

 struct _GIsiSubBlockIter {
 	uint8_t *start;
@@ -46,28 +45,28 @@ void g_isi_sb_iter_init(GIsiSubBlockIter *iter,
 void g_isi_sb_iter_init_full(GIsiSubBlockIter *iter,
 				const void *restrict data,
 				size_t len, size_t used,
-				bool longhdr,
+				gboolean longhdr,
 				uint16_t sub_blocks);
-bool g_isi_sb_iter_is_valid(const GIsiSubBlockIter *iter);
+gboolean g_isi_sb_iter_is_valid(const GIsiSubBlockIter *iter);
 =

-bool g_isi_sb_iter_next(GIsiSubBlockIter *iter);
+gboolean g_isi_sb_iter_next(GIsiSubBlockIter *iter);
 =

 int g_isi_sb_iter_get_id(const GIsiSubBlockIter *iter);
 size_t g_isi_sb_iter_get_len(const GIsiSubBlockIter *iter);
 =

-bool g_isi_sb_iter_get_data(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_data(const GIsiSubBlockIter *restrict iter,
 				void **data, unsigned pos);
-bool g_isi_sb_iter_get_byte(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_byte(const GIsiSubBlockIter *restrict iter,
 				uint8_t *byte, unsigned pos);
-bool g_isi_sb_iter_get_word(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_word(const GIsiSubBlockIter *restrict iter,
 				uint16_t *word, unsigned pos);
-bool g_isi_sb_iter_get_dword(const GIsiSubBlockIter *restrict iter,
-				uint32_t *dword, unsigned pos);
-bool g_isi_sb_iter_get_oper_code(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_dword(const GIsiSubBlockIter *restrict iter,
+					uint32_t *dword, unsigned pos);
+gboolean g_isi_sb_iter_get_oper_code(const GIsiSubBlockIter *restrict iter,
 					char *mcc, char *mnc, unsigned pos);
-bool g_isi_sb_iter_get_alpha_tag(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_alpha_tag(const GIsiSubBlockIter *restrict iter,
 					char **utf8, size_t len, unsigned pos);
-bool g_isi_sb_iter_get_latin_tag(const GIsiSubBlockIter *restrict iter,
+gboolean g_isi_sb_iter_get_latin_tag(const GIsiSubBlockIter *restrict iter,
 					char **ascii, size_t len, unsigned pos);
 =

 #ifdef __cplusplus
diff --git a/gisi/netlink.c b/gisi/netlink.c
index 06d4863..7ef8ec0 100644
--- a/gisi/netlink.c
+++ b/gisi/netlink.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 =

-#include <stdbool.h>
 #include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/gisi/netlink.h b/gisi/netlink.h
index 5b58fa4..816cd74 100644
--- a/gisi/netlink.h
+++ b/gisi/netlink.h
@@ -21,7 +21,6 @@
  *
  */
 =

-#include <stdbool.h>
 #include <stdint.h>
 #include <gisi/modem.h>
 =

diff --git a/gisi/pipe.c b/gisi/pipe.c
index 0e7698d..55852b1 100644
--- a/gisi/pipe.c
+++ b/gisi/pipe.c
@@ -26,7 +26,6 @@
 #endif
 =

 #include <stdint.h>
-#include <stdbool.h>
 #include <errno.h>
 #include <glib.h>
 #include "client.h"
@@ -125,8 +124,8 @@ struct _GIsiPipe {
 	void *opaque;
 	int error;
 	uint8_t handle;
-	bool enabled;
-	bool enabling;
+	gboolean enabled;
+	gboolean enabling;
 };
 =

 static int g_isi_pipe_error(uint8_t code)
@@ -163,16 +162,16 @@ static void g_isi_pipe_handle_error(GIsiPipe *pipe, u=
int8_t code)
 		pipe->error_handler(pipe);
 }
 =

-static bool g_isi_pipe_created(GIsiClient *client,
-				const void *restrict data, size_t len,
-				uint16_t object, void *opaque)
+static gboolean g_isi_pipe_created(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	GIsiPipe *pipe =3D opaque;
 	const isi_pipe_resp_t *resp =3D data;
 =

 	if (len < 5 ||
 	    resp->cmd !=3D PNS_PIPE_CREATE_RESP)
-		return false;
+		return FALSE;
 =

 	if (resp->pipe_handle !=3D PN_PIPE_INVALID_HANDLE) {
 		pipe->handle =3D resp->pipe_handle;
@@ -182,7 +181,7 @@ static bool g_isi_pipe_created(GIsiClient *client,
 			pipe->handler(pipe);
 	} else
 		g_isi_pipe_handle_error(pipe, resp->error_code);
-	return true;
+	return TRUE;
 }
 =

 /**
@@ -220,8 +219,8 @@ GIsiPipe *g_isi_pipe_create(GIsiModem *modem, void (*cr=
eated)(GIsiPipe *),
 	pipe->handler =3D created;
 	pipe->error_handler =3D NULL;
 	pipe->error =3D 0;
-	pipe->enabling =3D false;
-	pipe->enabled =3D false;
+	pipe->enabling =3D FALSE;
+	pipe->enabled =3D FALSE;
 	pipe->handle =3D PN_PIPE_INVALID_HANDLE;
 =

 	if (pipe->client =3D=3D NULL ||
@@ -250,22 +249,22 @@ g_isi_pipe_check_resp(const GIsiPipe *pipe, uint8_t c=
md,
 	return resp;
 }
 =

-static bool g_isi_pipe_enabled(GIsiClient *client,
-				const void *restrict data, size_t len,
-				uint16_t object, void *opaque)
+static gboolean g_isi_pipe_enabled(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	GIsiPipe *pipe =3D opaque;
 	const isi_pipe_resp_t *resp;
 =

 	resp =3D g_isi_pipe_check_resp(pipe, PNS_PIPE_ENABLE_RESP, data, len);
 	if (!resp)
-		return false;
+		return FALSE;
 =

 	g_isi_pipe_handle_error(pipe, resp->error_code);
-	pipe->enabling =3D false;
+	pipe->enabling =3D FALSE;
 	if (!pipe->error)
-		pipe->enabled =3D true;
-	return true;
+		pipe->enabled =3D TRUE;
+	return TRUE;
 }
 =

 static GIsiRequest *g_isi_pipe_enable(GIsiPipe *pipe)
@@ -295,26 +294,26 @@ int g_isi_pipe_start(GIsiPipe *pipe)
 	if (pipe->handle !=3D PN_PIPE_INVALID_HANDLE)
 		g_isi_pipe_enable(pipe);
 	else
-		pipe->enabling =3D true;
+		pipe->enabling =3D TRUE;
 =

 	return 0;
 }
 =

 /* Not very useful, it will never have time to trigger */
-static bool g_isi_pipe_removed(GIsiClient *client,
-				const void *restrict data, size_t len,
-				uint16_t object, void *opaque)
+static gboolean g_isi_pipe_removed(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	GIsiPipe *pipe =3D opaque;
 	const isi_pipe_resp_t *resp;
 =

 	resp =3D g_isi_pipe_check_resp(pipe, PNS_PIPE_REMOVE_RESP, data, len);
 	if (!resp)
-		return false;
+		return FALSE;
 =

 	pipe->handle =3D PN_PIPE_INVALID_HANDLE;
 	pipe->error =3D -EPIPE;
-	return true;
+	return TRUE;
 }
 =

 =

diff --git a/gisi/server.h b/gisi/server.h
index 080573f..d1be88e 100644
--- a/gisi/server.h
+++ b/gisi/server.h
@@ -27,7 +27,6 @@ extern "C" {
 #endif
 =

 #include <stdint.h>
-#include <stdbool.h>
 #include <gisi/modem.h>
 =

 struct _GIsiServer;
@@ -36,9 +35,9 @@ typedef struct _GIsiServer GIsiServer;
 struct _GIsiIncoming;
 typedef struct _GIsiIncoming GIsiIncoming;
 =

-typedef bool (*GIsiRequestFunc)(GIsiServer *server,
-		const void *restrict data, size_t len,
-		GIsiIncoming *, void *opaque);
+typedef gboolean (*GIsiRequestFunc)(GIsiServer *server,
+					const void *restrict data, size_t len,
+					GIsiIncoming *, void *opaque);
 =

 GIsiServer *g_isi_server_create(GIsiModem *modem, uint8_t resource,
 				uint8_t major, uint8_t minor);
diff --git a/gisi/verify.c b/gisi/verify.c
index ebedfbe..7ba0cdc 100644
--- a/gisi/verify.c
+++ b/gisi/verify.c
@@ -26,7 +26,6 @@
 #endif
 =

 #include <stdint.h>
-#include <stdbool.h>
 #include <glib.h>
 =

 #include "client.h"
@@ -43,14 +42,14 @@ struct verify_data {
 	void *data;
 };
 =

-static bool verify_cb(GIsiClient *client, const void *restrict data,
-			size_t len, uint16_t object, void *opaque)
+static gboolean verify_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
 {
 	const uint8_t *msg =3D data;
 	struct verify_data *vd =3D opaque;
 	GIsiVerifyFunc func =3D vd->func;
 =

-	bool alive =3D false;
+	gboolean alive =3D FALSE;
 =

 	if (!msg)
 		goto out;
@@ -60,18 +59,18 @@ static bool verify_cb(GIsiClient *client, const void *r=
estrict data,
 =

 	if (msg[1] =3D=3D COMM_ISI_VERSION_GET_RESP && len >=3D 4) {
 		g_isi_version_set(client, msg[2], msg[3]);
-		alive =3D true;
+		alive =3D TRUE;
 		goto out;
 	}
 =

 	if (msg[1] !=3D COMM_ISA_ENTITY_NOT_REACHABLE_RESP)
-		alive =3D true;
+		alive =3D TRUE;
 =

 out:
 	if (func)
 		func(client, alive, object, vd->data);
 	g_free(vd);
-	return true;
+	return TRUE;
 }
 =

 /**
-- =

1.6.3.3


--===============1348475568643303579==--

