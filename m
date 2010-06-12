Content-Type: multipart/mixed; boundary="===============6733921561916318160=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 02/11] gatserver: Check for disconnection when resuming
Date: Sat, 12 Jun 2010 13:50:41 +0800
Message-ID: <1276321850-13307-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1276321850-13307-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6733921561916318160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the internal GAtIO is no longer valid, treat it as if our channel was
disconnected.
---
 gatchat/gatserver.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 6bb9244..3fa26a0 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -1164,6 +1164,11 @@ void g_at_server_resume(GAtServer *server)
 =

 	server->suspended =3D FALSE;
 =

+	if (g_at_io_get_channel(server->io) =3D=3D NULL) {
+		io_disconnect(server);
+		return;
+	}
+
 	g_at_io_set_debug(server->io, server->debugf, server->debug_data);
 	g_at_io_set_read_handler(server->io, new_bytes, server);
 =

-- =

1.6.3.3


--===============6733921561916318160==--

