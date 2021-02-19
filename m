Content-Type: multipart/mixed; boundary="===============0432434433757753586=="
MIME-Version: 1.0
From: ofono@market.talbothome.com
Subject: [PATCH 04/09] MMSD: Ensure Compatibilty with AT&T
Date: Fri, 19 Feb 2021 01:01:12 +0000
Message-ID: <20210219010112.2937.43652@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0432434433757753586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AT&T requires explicit closing of the web connection, and has a DNS domain
for their proxy. This patch enables both those to have mmsd work with AT&T

---
 gweb/gweb.c   | 3 ++-
 src/service.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index f72e137..995d12f 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1309,7 +1309,8 @@ static guint do_request(GWeb *web, const char *url,
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
index 082e3bb..a9b07f6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2528,6 +2528,9 @@ void mms_service_bearer_notify(struct mms_service *se=
rvice, mms_bool_t active,
 =

 	g_web_set_debug(service->web, (GWebDebugFunc)debug_print, NULL);
 =

+	/* Explicitly close connections to work with AT&T */
+	g_web_set_close_connection(service->web,TRUE);
+
 	/* Sometimes no proxy is reported as string instead of NULL */
 	if (g_strcmp0(proxy, "") !=3D 0)
 		g_web_set_proxy(service->web, proxy);
-- =

2.30.0
--===============0432434433757753586==--

