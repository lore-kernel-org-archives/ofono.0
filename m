Content-Type: multipart/mixed; boundary="===============5064251248783453363=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v4 4/4] TODO: Mark Network/Modem EN update task as done
Date: Wed, 06 Apr 2011 07:26:43 -0700
Message-ID: <1302100003-5488-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1302100003-5488-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5064251248783453363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |   11 -----------
 doc/features.txt |   18 ++++++++++--------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/TODO b/TODO
index 85c5ad1..3491436 100644
--- a/TODO
+++ b/TODO
@@ -289,17 +289,6 @@ Sim Toolkit
   Complexity: C2
   Owner: Philippe Nunes <philippe.nunes@linux.intel.com>
 =

-Emergency Calls
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-- Network / Modem updating of the emergency number list. Support the list =
of
-  emergency numbers dynamically updated by the network or by the modem (e.=
g.
-  additional numbers burned into modem ROM).
-
-  Priority: High
-  Complexity: C2
-
-
 Miscellaneous
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

diff --git a/doc/features.txt b/doc/features.txt
index eb945c3..68d0676 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -583,14 +583,16 @@ Text Telephony
 Emergency Calls
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- EFecc support.  During SIM initialization phase oFono reads EFecc in ord=
er
-  to bootstrap the emergency calling codes provides by the SIM.  If the SI=
M is
-  not present or EFecc has not been read yet, the default set of emergency
-  calling codes is used.
-
-- Emergency number reporting.  The current known list of emergency calling
-  codes is reported by oFono in the EmergencyNumbers property on the
-  VoicecallManager interface.  When a voicecall is made to a number present
+- Emergency number reporting.  During SIM initialization phase oFono reads
+  EFecc in order to bootstrap the emergency calling codes provided by the =
SIM.
+  Emergency number list is exposed via the EmergencyNumbers property on the
+  VoicecallManager interface.  If SIM is present, list is the union of def=
ault
+  emergency numbers(112, 911), numbers in EFecc and Network / Modem report=
ed
+  emergency numbers.  If SIM is not present or EFecc has not been read yet,
+  list is the union of default emergency numbers(112, 911) and emergency
+  numbers without SIM(119, 118, 999, 110, 08 and 000).
+
+- Emergency call reporting.  When a voicecall is made to a number present
   on the EmergencyNumbers list it is automatically flagged as an emergency
   call.  This is done by setting the Emergency property on the Voicecall
   interface to TRUE.
-- =

1.7.0.4


--===============5064251248783453363==--

