Content-Type: multipart/mixed; boundary="===============6109737638456069980=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2] call-forwarding: class applied is the class given by SS
 code
Date: Thu, 23 Aug 2012 18:27:44 +0200
Message-ID: <1345739265-3080-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6109737638456069980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

GCF test cases 31.2.1.6.1/2 are asking to make a query according a specific
class.
The default class is applied when no class is specified in the SS code.
---
 src/call-forwarding.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 91e34c6..d73bcc0 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1012,7 +1012,12 @@ static void ss_set_query_cf_callback(const struct of=
ono_error *error, int total,
 =

 static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf)
 {
-	cf->driver->query(cf, cf->query_next, BEARER_CLASS_DEFAULT,
+	int cls;
+
+	cls =3D (cf->ss_req->cls =3D=3D BEARER_CLASS_SS_DEFAULT) ?
+			BEARER_CLASS_DEFAULT : cf->ss_req->cls;
+
+	cf->driver->query(cf, cf->query_next, cls,
 			ss_set_query_cf_callback, cf);
 }
 =

-- =

1.7.9.5


--===============6109737638456069980==--

