Content-Type: multipart/mixed; boundary="===============3620687264413105679=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] TODO: mark 'SIM PIN retry counter' task as done
Date: Mon, 10 Jan 2011 19:59:54 -0200
Message-ID: <1294696794-28903-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294696794-28903-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3620687264413105679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    8 --------
 doc/features.txt |    5 +++++
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/TODO b/TODO
index 12f313b..495d539 100644
--- a/TODO
+++ b/TODO
@@ -72,14 +72,6 @@ SIM / SIM File system
   Priority: Low
   Complexity: C2
 =

-- Support proprietary extensions for SIM PIN retry counter.  Most vendors
-  provide an extension commands to obtain such a retry counter for PINs and
-  PUKs.  Need to enable this as a property in oFono.
-
-  Priority: Low
-  Complexity: C2
-  Owner: Lucas De Marchi <lucas.demarchi@profusion.mobi>
-
 - Add support for SIM 'ready' notifications from the driver to the core.  =
Most
   modem manufacturers initialize the SIM (e.g. cache SIM file system, STK
   initialization, etc) internally before allowing the telephony stack to
diff --git a/doc/features.txt b/doc/features.txt
index a9fdb86..0a3357f 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -256,6 +256,11 @@ SIM
   ForwardingFlagOnSim will be set and VoiceUnconditional may contain the
   "forwarded to" number if the number is available.
 =

+- Support SIM retry counters. oFono exports all the retry counters availab=
le on
+  SIM, e.g., PIN, PIN2, PUK and PUK2. Whenever an action changes them, a s=
ignal
+  is sent with the updated values, so user can keep track of how many times
+  he/she can still give a wrong pin before the SIM locking down.
+
 Radio settings
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.3.5


--===============3620687264413105679==--

