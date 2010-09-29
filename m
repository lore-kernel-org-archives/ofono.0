Content-Type: multipart/mixed; boundary="===============8511332546664724745=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 12/21] gprs: ignore the case of proto str when comparing
Date: Wed, 29 Sep 2010 17:44:52 +0800
Message-ID: <1285753501-7668-13-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1285753501-7668-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8511332546664724745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use g_ascii_strcasecmp in gprs_proto_from_string when getting the GPRS
protocol from string.
---
 src/gprs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index f3f86ec..b39e361 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -159,10 +159,10 @@ const char *gprs_proto_to_string(enum ofono_gprs_prot=
o proto)
 =

 gboolean gprs_proto_from_string(const char *str, enum ofono_gprs_proto *pr=
oto)
 {
-	if (g_str_equal(str, "ip")) {
+	if (g_ascii_strcasecmp(str, "ip")) {
 		*proto =3D OFONO_GPRS_PROTO_IP;
 		return TRUE;
-	} else if (g_str_equal(str, "ipv6")) {
+	} else if (g_ascii_strcasecmp(str, "ipv6")) {
 		*proto =3D OFONO_GPRS_PROTO_IPV6;
 		return TRUE;
 	}
-- =

1.7.0.4


--===============8511332546664724745==--

