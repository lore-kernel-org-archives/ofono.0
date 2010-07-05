Content-Type: multipart/mixed; boundary="===============1566317876094632170=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] gatserver: Don't free twice after user disconnect
Date: Mon, 05 Jul 2010 10:59:12 +0800
Message-ID: <1278298752-10232-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1566317876094632170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's possible to free gatserver in user disconnect function. So we
should not free it again.
---
 gatchat/gatserver.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 3fa26a0..c63f04b 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -1019,9 +1019,6 @@ static void io_disconnect(gpointer user_data)
 =

 	if (server->user_disconnect)
 		server->user_disconnect(server->user_disconnect_data);
-
-	if (server->destroyed)
-		g_free(server);
 }
 =

 static void server_wakeup_writer(GAtServer *server)
-- =

1.6.3.3


--===============1566317876094632170==--

