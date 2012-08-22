Content-Type: multipart/mixed; boundary="===============3793264855853917115=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 6/8] call-barring: class applied is the class given by SS code
Date: Wed, 22 Aug 2012 18:18:21 +0200
Message-ID: <1345652303-12866-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345652303-12866-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3793264855853917115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The default class is applied when no class is specified in the SS code.
---
 src/call-barring.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 68533c2..a372792 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -308,11 +308,7 @@ static void cb_ss_query_next_lock_callback(const struc=
t ofono_error *error,
 =

 static void cb_ss_query_next_lock(struct ofono_call_barring *cb)
 {
-	int cls;
-
-	cls =3D cb->ss_req_cls | BEARER_CLASS_DEFAULT;
-
-	cb->driver->query(cb, cb_locks[cb->query_next].fac, cls,
+	cb->driver->query(cb, cb_locks[cb->query_next].fac, cb->ss_req_cls,
 			cb_ss_query_next_lock_callback, cb);
 }
 =

-- =

1.7.9.5


--===============3793264855853917115==--

