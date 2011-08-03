Content-Type: multipart/mixed; boundary="===============7843485031150013215=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] TODO: mark HFP AG emulator task as done
Date: Wed, 03 Aug 2011 15:53:41 +0200
Message-ID: <1312379621-13279-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7843485031150013215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    8 --------
 doc/features.txt |    7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/TODO b/TODO
index ab8ccff..f03a112 100644
--- a/TODO
+++ b/TODO
@@ -94,14 +94,6 @@ SIM / SIM File system
 Modem Emulator
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- Support HFP AG emulator.  We should provide a new HFP_AG_EMULATOR atom t=
ype
-  that will implement the Bluetooth HFP AG profile.  Voicecall atom, netreg
-  atoms can register command handlers for this atom appropriately.
-
-  Complexity: C4
-  Priority: Medium
-  Owner: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com>
-
 - Support CE4A extensions to HFP AG emulator. CE4A defines additional
   AT command extensions to the Bluetooth HFP AG standard. Refer to CE4A
   white paper: "AT-commands for Automotive Premium Phone Integration".
diff --git a/doc/features.txt b/doc/features.txt
index 46cd79d..525ca85 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -670,3 +670,10 @@ PPP Stack
   PPP stack supports both receiving and sending of packets with ACFC enabl=
ed.
   The user can also control whether ACFC capability is advertised to the p=
eer,
   and used during transmission.
+
+Modem Emulator
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Support HandsFree Profile Audio Gateway (HFP AG) emulator.
+  Supported feature are: 3-way calling, ability to reject a call, enhanced=
 call
+  status, enhanced call control and report of extended error results code.
-- =

1.7.1


--===============7843485031150013215==--

