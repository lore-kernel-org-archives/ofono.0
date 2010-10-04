Content-Type: multipart/mixed; boundary="===============7177149794729301432=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] TODO: BDN description update
Date: Mon, 04 Oct 2010 04:26:27 -0700
Message-ID: <1286191587-7297-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1286191587-7297-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7177149794729301432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/TODO b/TODO
index ab1ca89..8d4a26e 100644
--- a/TODO
+++ b/TODO
@@ -92,11 +92,12 @@ SIM / SIM File system
   Complexity: C2
   Owner: Petteri Tikander <petteri.tikander@ixonos.com>
 =

-- Barred Numbers.  oFono should support Barred Numbers capability.  This
-  requires ability to read & write EFadn entries on the SIM.
+- Barred Dialing numbers support.  BDN will not be supported by oFono.
+  If BDN service enabled SIM is used, oFono will go into emergency mode.
 =

   Priority: Low
-  Complexity: C4
+  Complexity: C2
+  Owner: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
 =

 - Read / Write EFcfis.  Call forwarding settings can be bootstrapped on the
   SIM for faster notification of the user that call forwarding is active.
-- =

1.7.0.4


--===============7177149794729301432==--

