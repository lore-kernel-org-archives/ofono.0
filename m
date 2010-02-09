Content-Type: multipart/mixed; boundary="===============8337201875824038501=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/4] Replace sprintf with snprintf
Date: Tue, 09 Feb 2010 22:59:28 +0800
Message-ID: <1265727570-6021-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1265727570-6021-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8337201875824038501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 16c976d..ad6afb9 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -116,9 +116,10 @@ static void g_at_server_send_result(GAtServer *server,=
 GAtServerResult result)
 		return;
 =

 	if (v250.is_v1)
-		sprintf(buf, "%c%c%s%c%c", t, r, result_str, t, r);
+		snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result_str,
+				t, r);
 	else
-		sprintf(buf, "%u%c", (unsigned int) result, t);
+		snprintf(buf, sizeof(buf), "%u%c", (unsigned int) result, t);
 =

 	g_at_util_debug_chat(FALSE, buf, strlen(buf),
 				server->debugf, server->debug_data);
-- =

1.6.6.1


--===============8337201875824038501==--

