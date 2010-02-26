Content-Type: multipart/mixed; boundary="===============6767224120593412527=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/4] Add define for read and write buffer size
Date: Fri, 26 Feb 2010 17:56:30 +0800
Message-ID: <1267178192-21396-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267178192-21396-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6767224120593412527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 95a9e8f..15bbbff 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -32,6 +32,8 @@
 #include "ringbuffer.h"
 #include "gatserver.h"
 =

+#define BUF_SIZE 4096
+
 enum ParserState {
 	PARSER_STATE_IDLE,
 	PARSER_STATE_A,
@@ -480,7 +482,7 @@ GAtServer *g_at_server_new(GIOChannel *io)
 	server->ref_count =3D 1;
 	v250_settings_create(&server->v250);
 	server->channel =3D io;
-	server->read_buf =3D ring_buffer_new(4096);
+	server->read_buf =3D ring_buffer_new(BUF_SIZE);
 	server->max_read_attempts =3D 3;
 =

 	if (!server->read_buf)
-- =

1.6.6.1


--===============6767224120593412527==--

