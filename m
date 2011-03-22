Content-Type: multipart/mixed; boundary="===============3855601633129764893=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/6] gat: add GAtSuspendFunc CB typedef
Date: Tue, 22 Mar 2011 10:36:46 +0100
Message-ID: <1300786611-11055-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3855601633129764893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gat.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/gat.h b/gatchat/gat.h
index ddf8695..f067389 100644
--- a/gatchat/gat.h
+++ b/gatchat/gat.h
@@ -32,6 +32,7 @@ typedef void (*GAtDisconnectFunc)(gpointer user_data);
 typedef void (*GAtReceiveFunc)(const unsigned char *data, gsize size,
 							gpointer user_data);
 typedef void (*GAtDebugFunc)(const char *str, gpointer user_data);
+typedef void (*GAtSuspendFunc)(gpointer user_data);
 =

 #ifdef __cplusplus
 }
-- =

1.7.1


--===============3855601633129764893==--

