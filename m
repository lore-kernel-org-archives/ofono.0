Content-Type: multipart/mixed; boundary="===============8876944588178228320=="
MIME-Version: 1.0
From: Christopher Talbot <chris@talbothome.com>
Subject: [PATCH 3/9] Ensure Compatibility with AT&T
Date: Wed, 24 Feb 2021 19:44:33 -0500
Message-ID: <516fcb0a72a70d9f95ecea1a45fa261ce3f3f2ec.camel@talbothome.com>
In-Reply-To: <20210225003933.2871.63570@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8876944588178228320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fixes two issues to ensure compatibility with AT&T:
1) Explicity close connections to the mmsc
2) Allow MMS Proxies that are domain names
---
 gweb/gweb.c   | 3 ++-
 src/service.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index f72e137..995d12f 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1309,7 +1309,8 @@ static guint do_request(GWeb *web, const char
*url,
 			session->address =3D g_strdup(session->host);
 =

 		memset(&hints, 0, sizeof(struct addrinfo));
-		hints.ai_flags =3D AI_NUMERICHOST;
+		/* Comment out next line to have AT&T MMS proxy work */
+		//hints.ai_flags =3D AI_NUMERICHOST;
 		hints.ai_family =3D session->web->family;
 =

 		if (session->addr !=3D NULL) {
diff --git a/src/service.c b/src/service.c
index c7ef255..a3b90c5 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2527,6 +2527,9 @@ void mms_service_bearer_notify(struct mms_service
*service, mms_bool_t active,
 =

 	g_web_set_debug(service->web, (GWebDebugFunc)debug_print,
NULL);
 =

+	/* Explicitly close connections to work with AT&T */
+	g_web_set_close_connection(service->web,TRUE);
+
 	/* Sometimes no proxy is reported as string instead of NULL */
 	if (g_strcmp0(proxy, "") !=3D 0)
 		g_web_set_proxy(service->web, proxy);
-- =

2.30.0

--===============8876944588178228320==--

