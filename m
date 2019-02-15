Content-Type: multipart/mixed; boundary="===============6574428968006659614=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/3] gprs-context: Adding get function for inteface
Date: Fri, 15 Feb 2019 17:37:15 +0530
Message-ID: <1550232435-28906-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6574428968006659614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added definition of get function to get interface value in
gprs-context
---
 src/gprs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 3dce001..b0d56e1 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2811,6 +2811,11 @@ enum ofono_gprs_context_type ofono_gprs_context_get_=
type(
 	return gc->type;
 }
 =

+const char *ofono_gprs_context_get_interface(struct ofono_gprs_context *gc)
+{
+	return gc->interface;
+}
+
 void ofono_gprs_context_set_interface(struct ofono_gprs_context *gc,
 					const char *interface)
 {
-- =

1.9.1


--===============6574428968006659614==--

