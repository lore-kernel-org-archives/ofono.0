Content-Type: multipart/mixed; boundary="===============4311554255853191821=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 3/4] call-barring: SS query is done according the class
 given by SS code
Date: Wed, 05 Sep 2012 18:56:21 +0200
Message-ID: <1346864182-24464-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346864182-24464-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4311554255853191821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The default class is applied in the query form when no class is
specified in the SS code.
---
 src/call-barring.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 68533c2..845cbc3 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -310,7 +310,8 @@ static void cb_ss_query_next_lock(struct ofono_call_bar=
ring *cb)
 {
 	int cls;
 =

-	cls =3D cb->ss_req_cls | BEARER_CLASS_DEFAULT;
+	cls =3D (cb->ss_req_type =3D=3D SS_CONTROL_TYPE_QUERY) ?
+			cb->ss_req_cls : cb->ss_req_cls | BEARER_CLASS_DEFAULT;
 =

 	cb->driver->query(cb, cb_locks[cb->query_next].fac, cls,
 			cb_ss_query_next_lock_callback, cb);
-- =

1.7.9.5


--===============4311554255853191821==--

