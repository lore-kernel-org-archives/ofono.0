Content-Type: multipart/mixed; boundary="===============3540049270212545298=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH] Fix: transaction id usage in gisi/server.c
Date: Thu, 22 Apr 2010 14:26:38 +0300
Message-ID: <1271935598-8519-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3540049270212545298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gisi/server.c |   90 +++++++++++++++++++++++++----------------------------=
---
 1 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/gisi/server.c b/gisi/server.c
index ef2d5dd..8eb28a7 100644
--- a/gisi/server.c
+++ b/gisi/server.c
@@ -44,7 +44,7 @@
 struct _GIsiIncoming
 {
 	struct sockaddr_pn spn;
-	uint8_t id;
+	uint8_t trans_id;
 };
 =

 struct _GIsiServer {
@@ -61,8 +61,6 @@ struct _GIsiServer {
 	GIsiRequestFunc func[256];
 	void *data[256];
 =

-	GIsiIncoming irq[1];
-
 	/* Debugging */
 	GIsiDebugFunc debug_func;
 	void *debug_data;
@@ -83,11 +81,11 @@ GIsiServer *g_isi_server_create(GIsiModem *modem, uint8=
_t resource,
 	GIsiServer *self;
 	GIOChannel *channel;
 =

-	if (G_UNLIKELY(posix_memalign(&ptr, 256, sizeof(*self))))
+	if (G_UNLIKELY(posix_memalign(&ptr, 256, (sizeof *self))))
 		abort();
 =

 	self =3D ptr;
-	memset (self, 0, sizeof *self);
+	memset (self, 0, (sizeof *self));
 	self->resource =3D resource;
 	self->version.major =3D major;
 	self->version.minor =3D minor;
@@ -174,9 +172,11 @@ g_isi_server_add_name(GIsiServer *self)
 			0, 0,
 		};
 =

-		if (sendto(self->fd, req, sizeof(req), 0, (void *)&spn,
-				sizeof(spn)) !=3D sizeof(spn))
-			return;
+		if (sendto(self->fd, req, (sizeof req), 0,
+			   (void *)&spn, (sizeof spn)) !=3D (sizeof req)) {
+			g_warning("%s: %s", "sendto(PN_NAMESERVICE)",
+				  strerror(errno));
+		}
 	}
 }
 =

@@ -236,7 +236,7 @@ int g_isi_vrespond(GIsiServer *self, const struct iovec=
 *iov, size_t iovlen,
 		return -1;
 	}
 =

-	_iov[0].iov_base =3D &irq->id;
+	_iov[0].iov_base =3D &irq->trans_id;
 	_iov[0].iov_len =3D 1;
 	for (i =3D 0, len =3D 1; i < iovlen; i++) {
 		_iov[1 + i] =3D iov[i];
@@ -245,8 +245,7 @@ int g_isi_vrespond(GIsiServer *self, const struct iovec=
 *iov, size_t iovlen,
 =

 	ret =3D sendmsg(self->fd, &msg, MSG_NOSIGNAL);
 =

-	if (irq !=3D self->irq)
-		g_free(irq);
+	g_free(irq);
 =

 	return ret;
 }
@@ -290,59 +289,50 @@ static gboolean g_isi_server_callback(GIOChannel *cha=
nnel, GIOCondition cond,
 					gpointer opaque)
 {
 	GIsiServer *self =3D opaque;
+	uint8_t msg[65536];
+	struct sockaddr_pn addr;
+	socklen_t addrlen =3D (sizeof addr);
 	int len;
-	GIsiIncoming *irq =3D self->irq;
-	struct sockaddr_pn *addr =3D &irq->spn;
-	socklen_t addrlen =3D sizeof(irq->spn);
+	uint8_t message_id;
+	uint8_t failure =3D 0x17;
+	GIsiRequestFunc func;
+	void *data;
 =

 	if (cond & (G_IO_NVAL|G_IO_HUP)) {
 		g_warning("Unexpected event on Phonet channel %p", channel);
 		return FALSE;
 	}
 =

-	len =3D phonet_peek_length(channel);
-	{
-		uint32_t buf[(len + 3) / 4];
-		uint8_t *msg;
-		uint8_t id;
-		uint8_t failure;
-		len =3D recvfrom(self->fd, buf, len, MSG_DONTWAIT,
-				(void *)addr, &addrlen);
-
-		if (len < 2 || irq->spn.spn_resource !=3D self->resource)
-			return TRUE;
-
-		msg =3D (uint8_t *)buf;
+	len =3D recvfrom(self->fd, msg, (sizeof msg), MSG_DONTWAIT,
+			(void *)&addr, &addrlen);
 =

-		if (self->debug_func)
-			self->debug_func(msg + 1, len - 1, self->debug_data);
+	if (len < 2 || addr.spn_resource !=3D self->resource)
+		return TRUE;
 =

-		irq->id =3D id =3D msg[1];
+	if (self->debug_func)
+		self->debug_func(msg + 1, len - 1, self->debug_data);
 =

-		if (self->func[id]) {
-			irq =3D g_new0(GIsiIncoming, 1);
+	message_id =3D msg[1];
+	func =3D self->func[message_id];
+	data =3D self->data[message_id];
 =

-			if (irq) {
-				*irq =3D *self->irq;
-				self->func[id](self, msg + 1, len - 1,
-						irq, self->data[id]);
-				return TRUE;
-			}
-			g_free(irq);
-			failure =3D 0x14;
+	if (func) {
+		GIsiIncoming *irq =3D g_new0(GIsiIncoming, 1);
 =

-		} else {
+		if (irq) {
+			irq->spn =3D addr;
+			irq->trans_id =3D msg[0];
+			(*func)(self, msg + 1, len - 1, irq, data);
+			return TRUE;
+		}
 =

-			failure =3D 0x17;
+		failure =3D 0x14;
+	}
 =

-			{
-				uint8_t common[] =3D {
-					0xF0, failure, msg[1]
-				};
-				g_isi_respond(self, common, sizeof(common),
-						irq);
-			}
-		}
+	{
+		uint8_t common[] =3D { msg[0], 0xF0, failure, msg[1] };
+		sendto(self->fd, common, (sizeof common), MSG_NOSIGNAL,
+			(void *)&addr, addrlen);
 	}
 =

 	return TRUE;
-- =

1.6.3.3


--===============3540049270212545298==--

