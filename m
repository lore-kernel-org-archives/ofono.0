Content-Type: multipart/mixed; boundary="===============2162547270471170940=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 05/11] test-server: Fix GIOChannel leak in create_tty
Date: Sat, 12 Jun 2010 13:50:44 +0800
Message-ID: <1276321850-13307-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1276321850-13307-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2162547270471170940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove client_io and unref server_io after creating GAtServer.
---
 gatchat/test-server.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 74ddd4d..5c1cfa4 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -722,7 +722,6 @@ static gboolean create_tty(const char *modem_path)
 	int master, slave;
 	char pty_name[256];
 	GIOChannel *server_io;
-	GIOChannel *client_io;
 =

 	if (!modem_path)
 		return FALSE;
@@ -732,9 +731,6 @@ static gboolean create_tty(const char *modem_path)
 =

 	set_raw_mode(slave);
 =

-	client_io =3D g_io_channel_unix_new(slave);
-	g_io_channel_set_close_on_unref(client_io, TRUE);
-
 	g_print("new pty is created at %s\n", pty_name);
 =

 	server_io =3D g_io_channel_unix_new(master);
@@ -747,6 +743,8 @@ static gboolean create_tty(const char *modem_path)
 		return FALSE;
 	}
 =

+	g_io_channel_unref(server_io);
+
 	return TRUE;
 }
 =

-- =

1.6.3.3


--===============2162547270471170940==--

