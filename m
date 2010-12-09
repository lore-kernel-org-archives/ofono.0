Content-Type: multipart/mixed; boundary="===============2945484604396755117=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 7/7] TODO: Marking the Read/Write EFcfis task as done
Date: Thu, 09 Dec 2010 09:44:01 -0800
Message-ID: <1291916641-531-8-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1291916641-531-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2945484604396755117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    9 ---------
 doc/features.txt |    5 +++++
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/TODO b/TODO
index 8d771d6..45c3577 100644
--- a/TODO
+++ b/TODO
@@ -92,15 +92,6 @@ SMS
 SIM / SIM File system
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- Read / Write EFcfis.  Call forwarding settings can be bootstrapped on the
-  SIM for faster notification of the user that call forwarding is active.
-  These settings are stored in EFcfis.  oFono should read these settings a=
nd
-  update the call forwarding atom appropriately.
-
-  Priority: Low
-  Complexity: C2
-  Owner: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
-
 - SIM Call History plugin.  New UICCs support four new SIM elementary files
   for storing call history information on the SIM: EFici, EFict, EFoci, EF=
oct.
   A plugin should be developed for oFono that will write to these files.
diff --git a/doc/features.txt b/doc/features.txt
index 950ec9a..6850d0b 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -222,6 +222,11 @@ SIM
   oFono halts the SIM initialization procedure and the modem remains in the
   PRESIM state.  In this state oFono will only allow emergency calls.
 =

+- Read / Write EFcfis / EFcphs-cff.  oFono reads EFcfis/EFcphs-cff SIM fil=
es
+  to check if VoiceUnconditional call forwarding rule is enabled.  If enab=
led,
+  ForwardingFlagOnSim will be set and VoiceUnconditional may contain the
+  "forwarded to" number if the number is available.
+
 Radio settings
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.0.4


--===============2945484604396755117==--

