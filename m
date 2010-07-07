Content-Type: multipart/mixed; boundary="===============1393189382514529877=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] test-server: Refactor set_raw_mode
Date: Wed, 07 Jul 2010 08:42:23 +0800
Message-ID: <1278463343-7822-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1393189382514529877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rename variable 'options' to 'ti' and use sizeof(ti).
---
 gatchat/test-server.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 2911978..49012dc 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -846,13 +846,13 @@ static void server_destroy(gpointer user)
 =

 static void set_raw_mode(int fd)
 {
-	struct termios options;
+	struct termios ti;
 =

-	memset(&options, 0, sizeof(struct termios));
-	tcgetattr(fd, &options);
+	memset(&ti, 0, sizeof(ti));
+	tcgetattr(fd, &ti);
 	tcflush(fd, TCIOFLUSH);
-	cfmakeraw(&options);
-	tcsetattr(fd, TCSANOW, &options);
+	cfmakeraw(&ti);
+	tcsetattr(fd, TCSANOW, &ti);
 }
 =

 static gboolean create_tty(const char *modem_path)
-- =

1.6.3.3


--===============1393189382514529877==--

