Content-Type: multipart/mixed; boundary="===============4719703107741493963=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/4] remove unneeded debug statement
Date: Wed, 24 Mar 2010 21:41:52 -0700
Message-ID: <1269492115-15412-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269492115-15412-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4719703107741493963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

cleanup old debug print statement
---
 gatchat/ppp.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/gatchat/ppp.c b/gatchat/ppp.c
index 4612976..f3bfba7 100644
--- a/gatchat/ppp.c
+++ b/gatchat/ppp.c
@@ -328,10 +328,8 @@ gboolean ppp_cb(GIOChannel *channel, GIOCondition cond=
, gpointer data)
 	gsize bytes_read;
 	GError *error =3D NULL;
 =

-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		g_print("G_IO_NVAL | G_IO_ERR");
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
 		return FALSE;
-	}
 =

 	if (cond & G_IO_IN) {
 		status =3D g_io_channel_read_chars(channel, buf, 256,
-- =

1.6.6.1


--===============4719703107741493963==--

