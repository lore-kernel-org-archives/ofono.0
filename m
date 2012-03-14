Content-Type: multipart/mixed; boundary="===============8789868133697351625=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 2/2] service: free the msg after tracing its path
Date: Wed, 14 Mar 2012 11:46:00 +0100
Message-ID: <1331721962-5843-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1331721962-5843-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8789868133697351625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move debug statement before freeing the message so the message path is
reliable
---
 src/service.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index fc69e0d..4ad9d39 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1607,10 +1607,10 @@ int mms_message_unregister(const struct mms_service=
 *service,
 		return -EIO;
 	}
 =

-	g_hash_table_remove(service->messages, msg_path);
-
 	DBG("message unregistered %s", msg_path);
 =

+	g_hash_table_remove(service->messages, msg_path);
+
 	return 0;
 }
 =

-- =

1.7.4.1


--===============8789868133697351625==--

