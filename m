Content-Type: multipart/mixed; boundary="===============5302400482905893963=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/2] gatserver: Restore GAtServer disconnect handling
Date: Wed, 07 Jul 2010 09:46:31 +0800
Message-ID: <1278467192-12207-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5302400482905893963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Restore GAtServer disconnect handling when resuming a server session
---
 gatchat/gatserver.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index c63f04b..49e0de4 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -1166,6 +1166,8 @@ void g_at_server_resume(GAtServer *server)
 		return;
 	}
 =

+	g_at_io_set_disconnect_function(server->io, io_disconnect, server);
+
 	g_at_io_set_debug(server->io, server->debugf, server->debug_data);
 	g_at_io_set_read_handler(server->io, new_bytes, server);
 =

-- =

1.6.3.3


--===============5302400482905893963==--

