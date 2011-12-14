Content-Type: multipart/mixed; boundary="===============6258992399817018095=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 06/10] gatchat: Add g_at_chat_set_slave_qcdm /
 g_at_chat_get_slave_qcdm
Date: Wed, 14 Dec 2011 18:56:08 +0100
Message-ID: <1323885372-3574-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1323885372-3574-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6258992399817018095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.c |   26 ++++++++++++++++++++++++++
 gatchat/gatchat.h |    4 ++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 7a0ef35..2fde572 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -35,6 +35,7 @@
 #include "ringbuffer.h"
 #include "gatchat.h"
 #include "gatio.h"
+#include "gathdlc.h"
 =

 /* #define WRITE_SCHEDULER_DEBUG 1 */
 =

@@ -110,6 +111,7 @@ struct _GAtChat {
 	struct at_chat *parent;
 	guint group;
 	GAtChat *slave;
+	GAtHDLC	*qcdm;
 };
 =

 struct terminator_info {
@@ -1354,6 +1356,30 @@ GAtChat *g_at_chat_get_slave(GAtChat *chat)
 	return chat->slave;
 }
 =

+GAtHDLC *g_at_chat_set_slave_qcdm(GAtChat *chat, GAtHDLC *diag)
+{
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (chat->qcdm !=3D NULL)
+		g_at_hdlc_unref(chat->qcdm);
+
+	if (diag !=3D NULL)
+		chat->qcdm =3D g_at_hdlc_ref(diag);
+	else
+		chat->qcdm =3D NULL;
+
+	return chat->qcdm;
+}
+
+GAtHDLC *g_at_chat_get_slave_qcdm(GAtChat *chat)
+{
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	return chat->qcdm;
+}
+
 GIOChannel *g_at_chat_get_channel(GAtChat *chat)
 {
 	if (chat =3D=3D NULL || chat->parent->io =3D=3D NULL)
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index 367581e..496b3dc 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -30,6 +30,7 @@ extern "C" {
 #include "gatsyntax.h"
 #include "gatutil.h"
 #include "gatio.h"
+#include "gathdlc.h"
 =

 struct _GAtChat;
 =

@@ -68,6 +69,9 @@ GAtChat *g_at_chat_clone(GAtChat *chat);
 GAtChat *g_at_chat_set_slave(GAtChat *chat, GAtChat *slave);
 GAtChat *g_at_chat_get_slave(GAtChat *chat);
 =

+GAtHDLC *g_at_chat_set_slave_qcdm(GAtChat *chat, GAtHDLC *diag);
+GAtHDLC *g_at_chat_get_slave_qcdm(GAtChat *chat);
+
 void g_at_chat_suspend(GAtChat *chat);
 void g_at_chat_resume(GAtChat *chat);
 =

-- =

1.7.1


--===============6258992399817018095==--

