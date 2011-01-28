Content-Type: multipart/mixed; boundary="===============8504566376348589753=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH] TODO: add CF state change task
Date: Fri, 28 Jan 2011 15:14:04 +0200
Message-ID: <1296220444-2680-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8504566376348589753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 41f1f7f..b62eb99 100644
--- a/TODO
+++ b/TODO
@@ -255,6 +255,22 @@ Supplementary Services
   Priority: Low
   Complexity: C8
 =

+- Call forwarding state handling change
+
+  At the moment call forwarding states are not always correct. Any active
+  conditional call forwarding should become quiescent while unconditional =
call
+  forwarding is activate. If call forwarding unconditional is subsequently
+  deactivated, all the quiescent forwardings should become operative again.
+  I.e. No conditional call forwardin string should be returned while
+  unconditional call forwarding is active even if they exist.
+
+  If there is an successfull attempt to activate/deactivate conditional ca=
ll
+  forwarding while unconditional call forwarding is active the conditional=
 cache
+  flag should cleared.
+
+  Priority: Low
+  Complexity: C1
+
 =

 Voicecall
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
-- =

1.7.0.4


--===============8504566376348589753==--

