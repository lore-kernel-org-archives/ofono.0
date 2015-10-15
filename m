Content-Type: multipart/mixed; boundary="===============2032108844746786110=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 05/10] gril: Remove asserts
Date: Thu, 15 Oct 2015 18:46:58 +0200
Message-ID: <1444927623-31141-6-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444927623-31141-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2032108844746786110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gril/gril.c   | 23 +++++++++++------------
 gril/grilio.c |  3 +--
 gril/grilio.h |  2 ++
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/gril/gril.c b/gril/gril.c
index 2d9f4b2..2e4459c 100644
--- a/gril/gril.c
+++ b/gril/gril.c
@@ -29,7 +29,6 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <string.h>
-#include <assert.h>
 #include <ctype.h>
 #include <errno.h>
 #include <sys/socket.h>
@@ -364,14 +363,12 @@ static void io_disconnect(gpointer user_data)
 =

 static void handle_response(struct ril_s *p, struct ril_msg *message)
 {
-	gsize count =3D g_queue_get_length(p->command_queue);
+	guint count =3D g_queue_get_length(p->command_queue);
 	struct ril_request *req;
 	gboolean found =3D FALSE;
 	guint i, len;
 	gint id;
 =

-	g_assert(count > 0);
-
 	for (i =3D 0; i < count; i++) {
 		req =3D g_queue_peek_nth(p->command_queue, i);
 =

@@ -560,16 +557,20 @@ static struct ril_msg *read_fixed_record(struct ril_s=
 *p,
 	bytes +=3D 4;
 =

 	/*
-	 * TODO: Verify that 4k is the max message size from rild.
+	 * TODO: Verify that 8k is the max message size from rild.
 	 *
-	 * These conditions shouldn't happen.  If it does
+	 * This condition shouldn't happen.  If it does
 	 * there are three options:
 	 *
-	 * 1) ASSERT; ofono will restart via DBus
+	 * 1) Exit; ofono will restart via DBus (this is what we do now)
 	 * 2) Consume the bytes & continue
 	 * 3) force a disconnect
 	 */
-	g_assert(plen >=3D 8 && plen <=3D 4092);
+	if (plen > GRIL_BUFFER_SIZE - 4) {
+		ofono_error("ERROR RIL parcel bigger than buffer (%u), exiting",
+				plen);
+		exit(1);
+	}
 =

 	/*
 	 * If we don't have the whole fixed record in the ringbuffer
@@ -580,13 +581,11 @@ static struct ril_msg *read_fixed_record(struct ril_s=
 *p,
 	if (message_len < plen)
 		return NULL;
 =

-	message =3D g_try_malloc(sizeof(struct ril_msg));
-	g_assert(message !=3D NULL);
+	message =3D g_malloc(sizeof(struct ril_msg));
 =

 	/* allocate ril_msg->buffer */
 	message->buf_len =3D plen;
-	message->buf =3D g_try_malloc(plen);
-	g_assert(message->buf !=3D NULL);
+	message->buf =3D g_malloc(plen);
 =

 	/* Copy bytes into message buffer */
 	memmove(message->buf, (const void *) bytes, plen);
diff --git a/gril/grilio.c b/gril/grilio.c
index f02d0e4..9f7f116 100644
--- a/gril/grilio.c
+++ b/gril/grilio.c
@@ -27,7 +27,6 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <string.h>
-#include <assert.h>
 #include <ctype.h>
 #include <errno.h>
 =

@@ -206,7 +205,7 @@ static GRilIO *create_io(GIOChannel *channel, GIOFlags =
flags)
 		io->use_write_watch =3D FALSE;
 	}
 =

-	io->buf =3D ring_buffer_new(8192);
+	io->buf =3D ring_buffer_new(GRIL_BUFFER_SIZE);
 =

 	if (!io->buf)
 		goto error;
diff --git a/gril/grilio.h b/gril/grilio.h
index 22fb60e..58e42a1 100644
--- a/gril/grilio.h
+++ b/gril/grilio.h
@@ -29,6 +29,8 @@ extern "C" {
 =

 #include "gfunc.h"
 =

+#define GRIL_BUFFER_SIZE 8192
+
 struct _GRilIO;
 =

 typedef struct _GRilIO GRilIO;
-- =

2.1.4


--===============2032108844746786110==--

