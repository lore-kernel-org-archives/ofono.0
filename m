Content-Type: multipart/mixed; boundary="===============1534404143353450932=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 8/8] TODO: Remove completed call forwarding state task
Date: Mon, 06 Feb 2012 14:34:01 +0200
Message-ID: <1328531641-10612-9-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1328531641-10612-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1534404143353450932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/TODO b/TODO
index 1fef651..9948117 100644
--- a/TODO
+++ b/TODO
@@ -213,23 +213,6 @@ Supplementary Services
   Priority: Low
   Complexity: C8
 =

-- Call forwarding state handling change
-
-  At the moment call forwarding states are not always correct. Any active
-  conditional call forwarding should become quiescent while unconditional =
call
-  forwarding is activate. If call forwarding unconditional is subsequently
-  deactivated, all the quiescent forwardings should become operative again.
-  I.e. No conditional call forwarding string should be returned while
-  unconditional call forwarding is active even if they exist.
-
-  If there is an successful attempt to activate/deactivate conditional call
-  forwarding while unconditional call forwarding is active the conditional=
 cache
-  flag should cleared.
-
-  Priority: High
-  Complexity: C1
-  Owner: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
-
 =

 Voicecall
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
-- =

1.7.5.4


--===============1534404143353450932==--

