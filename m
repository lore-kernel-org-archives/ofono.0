Content-Type: multipart/mixed; boundary="===============0691359766907283980=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 2/4] call-forwarding: SS query is done according the class
 given by SS code
Date: Wed, 05 Sep 2012 18:56:20 +0200
Message-ID: <1346864182-24464-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346864182-24464-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0691359766907283980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

GCF test cases 31.2.1.6.1/2 are asking to make a query according a
specific class.
The default class is applied in the query form when no class is
specified in the SS code.
---
 src/call-forwarding.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 91e34c6..2746771 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1012,7 +1012,15 @@ static void ss_set_query_cf_callback(const struct of=
ono_error *error, int total,
 =

 static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf)
 {
-	cf->driver->query(cf, cf->query_next, BEARER_CLASS_DEFAULT,
+	int cls;
+
+	cls =3D (cf->ss_req->ss_type =3D=3D SS_CONTROL_TYPE_QUERY) ?
+			cf->ss_req->cls : BEARER_CLASS_DEFAULT;
+
+	if (cls =3D=3D BEARER_CLASS_SS_DEFAULT)
+			cls =3D BEARER_CLASS_DEFAULT;
+
+	cf->driver->query(cf, cf->query_next, cls,
 			ss_set_query_cf_callback, cf);
 }
 =

-- =

1.7.9.5


--===============0691359766907283980==--

