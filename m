Content-Type: multipart/mixed; boundary="===============4830033055949690507=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 12/21] gprs: ignore the case of proto str when comparing
Date: Wed, 12 Jan 2011 18:15:55 +0100
Message-ID: <1294852564-1258-13-git-send-email-frederic.dalleau@intel.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4830033055949690507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zhenhua Zhang <zhenhua.zhang@intel.com>

Use g_ascii_strcasecmp in gprs_proto_from_string when getting the GPRS
protocol from string.
---
 src/gprs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 9e8fae3..830e143 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -199,10 +199,10 @@ const char *gprs_proto_to_string(enum ofono_gprs_prot=
o proto)
 gboolean gprs_proto_from_string(const char *str,
 					enum ofono_gprs_proto *proto)
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

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============4830033055949690507==--

