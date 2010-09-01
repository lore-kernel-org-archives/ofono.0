Content-Type: multipart/mixed; boundary="===============3661327065006261396=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [g_isi_send PATCH 1/3] gisi: added g_isi_send() and g_isi_vsend()
Date: Wed, 01 Sep 2010 14:47:46 +0300
Message-ID: <1283341668-18356-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3661327065006261396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Include a finalize function in GIsiRequest
---
 gisi/client.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++---=
---
 gisi/client.h |   12 ++++++++
 2 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/gisi/client.c b/gisi/client.c
index 640484d..603e785 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -52,6 +52,7 @@ struct _GIsiRequest {
 	guint timeout;
 	GIsiResponseFunc func;
 	void *data;
+	GDestroyNotify notify;
 };
 =

 struct _GIsiIndication {
@@ -240,6 +241,9 @@ static void g_isi_cleanup_req(void *data)
 		req->func(req->client, NULL, 0, 0, req->data);
 	req->client->error =3D 0;
 =

+	if (req->notify)
+		req->notify(req->data);
+
 	if (req->timeout > 0)
 		g_source_remove(req->timeout);
 =

@@ -329,31 +333,84 @@ GIsiRequest *g_isi_request_make(GIsiClient *client, c=
onst void *__restrict buf,
 				size_t len, unsigned timeout,
 				GIsiResponseFunc cb, void *opaque)
 {
+	return g_isi_send(client, buf, len, timeout, cb, opaque, NULL);
+}
+
+/**
+ * Make an ISI request and register a callback to process the response(s) =
to
+ * the resulting transaction.
+ * @param cl ISI client (from g_isi_client_create())
+ * @param iov scatter-gather array to the request payload
+ * @param iovlen number of vectors in the scatter-gather array
+ * @param timeout timeout in seconds
+ * @param cb callback to process response(s)
+ * @param opaque data for the callback
+ */
+GIsiRequest *g_isi_request_vmake(GIsiClient *client, const struct iovec *i=
ov,
+					size_t iovlen, unsigned timeout,
+					GIsiResponseFunc func, void *opaque)
+{
+	return g_isi_vsend(client, iov, iovlen, timeout, func, opaque, NULL);
+}
+
+/**
+ * Send an ISI request and register a callback to process the response(s) =
to
+ * the resulting transaction.
+ *
+ * @param cl ISI client (from g_isi_client_create())
+ * @param buf pointer to request payload
+ * @param len request payload byte length
+ * @param timeout timeout in seconds
+ * @param cb callback to process response(s)
+ * @param opaque data for the callback
+ * @param notify finalizer function for the @a opaque data (may be NULL)
+ *
+ * @return
+ * A pointer to a newly created GIsiRequest.
+ *
+ * @errors
+ * If an error occurs, @a errno is set accordingly and a NULL pointer is
+ * returned.
+ */
+GIsiRequest *g_isi_send(GIsiClient *client,
+			const void *__restrict buf, size_t len,
+			unsigned timeout,
+			GIsiResponseFunc cb, void *opaque,
+			GDestroyNotify notify)
+{
 	const struct iovec iov =3D {
 		.iov_base =3D (void *)buf,
 		.iov_len =3D len,
 	};
 =

-	if (!client)
-		return NULL;
-
-	return g_isi_request_vmake(client, &iov, 1, timeout, cb, opaque);
+	return g_isi_vsend(client, &iov, 1, timeout, cb, opaque, notify);
 }
 =

+
 /**
- * Make an ISI request and register a callback to process the response(s) =
to
+ * Send an ISI request and register a callback to process the response(s) =
to
  * the resulting transaction.
+ *
  * @param cl ISI client (from g_isi_client_create())
  * @param iov scatter-gather array to the request payload
  * @param iovlen number of vectors in the scatter-gather array
  * @param timeout timeout in seconds
  * @param cb callback to process response(s)
  * @param opaque data for the callback
+ * @param notify finalizer function for the @a opaque data (may be NULL)
+ *
+ * @return
+ * A pointer to a newly created GIsiRequest.
+ *
+ * @errors
+ * If an error occurs, @a errno is set accordingly and a NULL pointer is
+ * returned.
  */
-GIsiRequest *g_isi_request_vmake(GIsiClient *client,
-					const struct iovec *__restrict iov,
-					size_t iovlen, unsigned timeout,
-					GIsiResponseFunc cb, void *opaque)
+GIsiRequest *g_isi_vsend(GIsiClient *client,
+				const struct iovec *__restrict iov,
+				size_t iovlen, unsigned timeout,
+				GIsiResponseFunc cb, void *opaque,
+				GDestroyNotify notify)
 {
 	struct iovec _iov[1 + iovlen];
 	struct sockaddr_pn dst =3D {
@@ -390,6 +447,7 @@ GIsiRequest *g_isi_request_vmake(GIsiClient *client,
 	req->id =3D (client->reqs.last + 1) % 255;
 	req->func =3D cb;
 	req->data =3D opaque;
+	req->notify =3D notify;
 =

 	old =3D tsearch(req, &client->reqs.pending, g_isi_cmp);
 	if (!old) {
@@ -438,6 +496,7 @@ GIsiRequest *g_isi_request_vmake(GIsiClient *client,
 error:
 	tdelete(req, &client->reqs.pending, g_isi_cmp);
 	g_free(req);
+
 	return NULL;
 }
 =

@@ -455,6 +514,10 @@ void g_isi_request_cancel(GIsiRequest *req)
 		g_source_remove(req->timeout);
 =

 	tdelete(req, &req->client->reqs.pending, g_isi_cmp);
+
+	if (req->notify)
+		req->notify(req->data);
+
 	g_free(req);
 }
 =

diff --git a/gisi/client.h b/gisi/client.h
index 7046f31..e5ba01d 100644
--- a/gisi/client.h
+++ b/gisi/client.h
@@ -27,6 +27,7 @@ extern "C" {
 #endif
 =

 #include <stdint.h>
+#include <glib/gtypes.h>
 #include <gisi/modem.h>
 =

 struct _GIsiClient;
@@ -72,6 +73,17 @@ GIsiRequest *g_isi_request_vmake(GIsiClient *client, con=
st struct iovec *iov,
 					size_t iovlen, unsigned timeout,
 					GIsiResponseFunc func, void *opaque);
 =

+GIsiRequest *g_isi_send(GIsiClient *client, const void *data, size_t len,
+			unsigned timeout,
+			GIsiResponseFunc func, void *opaque,
+			GDestroyNotify notify);
+
+GIsiRequest *g_isi_vsend(GIsiClient *client,
+				const struct iovec *iov, size_t iovlen,
+				unsigned timeout,
+				GIsiResponseFunc func, void *opaque,
+				GDestroyNotify notify);
+
 void g_isi_request_cancel(GIsiRequest *req);
 =

 int g_isi_subscribe(GIsiClient *client, uint8_t type,
-- =

1.7.0.4


--===============3661327065006261396==--

