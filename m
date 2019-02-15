Content-Type: multipart/mixed; boundary="===============0228288312604604359=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/3] gprs-context: adding get function for network interface
Date: Fri, 15 Feb 2019 17:12:51 +0530
Message-ID: <1550230971-28751-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0228288312604604359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added declaration of get function to get network interface
for gprs-context
---
 include/gprs-context.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 965cefc..ad0872f 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -92,6 +92,8 @@ void ofono_gprs_context_set_type(struct ofono_gprs_contex=
t *gc,
 enum ofono_gprs_context_type ofono_gprs_context_get_type(
 						struct ofono_gprs_context *gc);
 =

+const char *ofono_gprs_context_get_interface(struct ofono_gprs_context *gc=
);
+
 void ofono_gprs_context_set_interface(struct ofono_gprs_context *gc,
 					const char *interface);
 =

-- =

1.9.1


--===============0228288312604604359==--

