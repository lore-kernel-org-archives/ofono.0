Content-Type: multipart/mixed; boundary="===============8415941184793771866=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 4/4] TODO: Marking the Barred Dialing task as done
Date: Mon, 25 Oct 2010 04:34:17 -0700
Message-ID: <1288006457-5415-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1288006457-5415-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8415941184793771866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    7 -------
 doc/features.txt |    5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/TODO b/TODO
index d9a6580..ad96241 100644
--- a/TODO
+++ b/TODO
@@ -110,13 +110,6 @@ SMS
 SIM / SIM File system
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- Barred Dialing numbers support.  BDN will not be supported by oFono.
-  If BDN service enabled SIM is used, oFono will go into emergency mode.
-
-  Priority: Low
-  Complexity: C2
-  Owner: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
-
 - Read / Write EFcfis.  Call forwarding settings can be bootstrapped on the
   SIM for faster notification of the user that call forwarding is active.
   These settings are stored in EFcfis.  oFono should read these settings a=
nd
diff --git a/doc/features.txt b/doc/features.txt
index 3524e79..12be037 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -135,3 +135,8 @@ SIM
   check if FDN support is allocated and enabled in the SIM.  If enabled,
   oFono halts the SIM initialization procedure and the modem remains in the
   PRESIM state.  In this state oFono will only allow emergency calls.
+
+- Barred Dialing support.  oFono reads the necessary bits from the SIM to
+  check if BDN support is allocated and enabled in the SIM.  If enabled,
+  oFono halts the SIM initialization procedure and the modem remains in the
+  PRESIM state.  In this state oFono will only allow emergency calls.
-- =

1.7.0.4


--===============8415941184793771866==--

