Content-Type: multipart/mixed; boundary="===============9212934454840169746=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/3] gatchat: implement g_at_chat_get_io()
Date: Mon, 10 May 2010 11:39:42 -0700
Message-ID: <1273516783-5132-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1273516783-5132-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9212934454840169746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.c |    8 ++++++++
 gatchat/gatchat.h |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index f94605f..3f238a2 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -876,6 +876,14 @@ GIOChannel *g_at_chat_get_channel(GAtChat *chat)
 	return g_at_io_get_channel(chat->io);
 }
 =

+GAtIO *g_at_chat_get_io(GAtChat *chat)
+{
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	return chat->io;
+}
+
 GAtChat *g_at_chat_ref(GAtChat *chat)
 {
 	if (chat =3D=3D NULL)
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index ea6626e..9fd7ced 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -29,6 +29,7 @@ extern "C" {
 #include "gatresult.h"
 #include "gatsyntax.h"
 #include "gatutil.h"
+#include "gatio.h"
 =

 struct _GAtChat;
 =

@@ -42,6 +43,7 @@ GAtChat *g_at_chat_new(GIOChannel *channel, GAtSyntax *sy=
ntax);
 GAtChat *g_at_chat_new_blocking(GIOChannel *channel, GAtSyntax *syntax);
 =

 GIOChannel *g_at_chat_get_channel(GAtChat *chat);
+GAtIO *g_at_chat_get_io(GAtChat *chat);
 =

 GAtChat *g_at_chat_ref(GAtChat *chat);
 void g_at_chat_unref(GAtChat *chat);
-- =

1.6.6.1


--===============9212934454840169746==--

