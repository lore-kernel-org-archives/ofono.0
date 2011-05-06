Content-Type: multipart/mixed; boundary="===============6019960921235814136=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Fix a gcc 4.5.2 warning uninit var
Date: Fri, 06 May 2011 14:04:46 +0200
Message-ID: <1304683486-17159-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6019960921235814136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 2068d6b..73ce433 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -36,6 +36,8 @@
 #include "common.h"
 #include "simutil.h"
 =

+#define uninitialized_var(x) x =3D x
+
 #define CALL_FORWARDING_FLAG_CACHED 0x1
 #define CALL_FORWARDING_FLAG_CPHS_CFF 0x2
 =

@@ -246,7 +248,7 @@ static gboolean is_cfu_enabled(struct ofono_call_forwar=
ding *cf,
 static void sim_set_cf_indicator(struct ofono_call_forwarding *cf)
 {
 	gboolean cfu_voice;
-	struct ofono_call_forwarding_condition *cond;
+	struct ofono_call_forwarding_condition *uninitialized_var(cond);
 =

 	cfu_voice =3D is_cfu_enabled(cf, &cond);
 =

-- =

1.7.4.1

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

--===============6019960921235814136==--

