Content-Type: multipart/mixed; boundary="===============5481028709427474703=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/2] switch to g_timeout_add_seconds()
Date: Wed, 24 Mar 2010 20:26:27 -0700
Message-ID: <1269487588-14046-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269487588-14046-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5481028709427474703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

we don't care that much about the exactness of our timer, so use
the more power efficient call.
---
 gatchat/ppp_cp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 3132af5..de72066 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -56,7 +56,7 @@ struct pppcp_event {
 	guint8 data[0];
 };
 =

-#define INITIAL_RESTART_TIMEOUT	3000
+#define INITIAL_RESTART_TIMEOUT	3	/* restart interval in seconds */
 #define MAX_TERMINATE		2
 #define MAX_CONFIGURE		10
 #define MAX_FAILURE		5
@@ -107,7 +107,7 @@ static gboolean pppcp_timeout(gpointer user_data)
 =

 static void pppcp_start_timer(struct pppcp_data *data)
 {
-	data->restart_timer =3D g_timeout_add(data->restart_interval,
+	data->restart_timer =3D g_timeout_add_seconds(data->restart_interval,
 				pppcp_timeout, data);
 }
 =

-- =

1.6.6.1


--===============5481028709427474703==--

