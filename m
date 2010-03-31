Content-Type: multipart/mixed; boundary="===============8607569467246875025=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix ignore incoming bytes during parsing
Date: Wed, 31 Mar 2010 10:40:08 +0800
Message-ID: <1270003208-32260-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8607569467246875025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Server processes one command line at one time, so ignore the rest
incoming bytes during the command parsing.
---
 gatchat/gatserver.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index e04e0d2..911bbef 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -781,6 +781,10 @@ static gboolean received_data(GIOChannel *channel, GIO=
Condition cond,
 		g_at_util_debug_chat(TRUE, (char *)buf, rbytes,
 					server->debugf, server->debug_data);
 =

+		/* Ignore incoming bytes when processing a command line */
+		if (server->processing_cmdline)
+			continue;
+
 		read_count++;
 =

 		total_read +=3D rbytes;
-- =

1.6.6.1


--===============8607569467246875025==--

