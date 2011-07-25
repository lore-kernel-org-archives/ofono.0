Content-Type: multipart/mixed; boundary="===============3580642441782587555=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] TODO: add HFP AG tasks related to BlueZ/PA
Date: Mon, 25 Jul 2011 16:27:24 +0200
Message-ID: <1311604044-10093-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3580642441782587555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index b464b19..ab8ccff 100644
--- a/TODO
+++ b/TODO
@@ -147,6 +147,23 @@ Modem Emulator
   Priority: Low
   Depends: HFP AG emulator
 =

+- Integrate HFP AG emulator as a BlueZ service.
+  Replace direct access to Bluetooth library by usage of the BlueZ service
+  architecture.
+
+  Complexity: C2
+  Priority: Medium
+  Depends: HFP AG emulator
+
+- Add audio management to HFP AG emulator.
+  Integrate HFP AG emulator to BlueZ and Pulse Audio.
+  Add audio related AT commands support: remote audio volume control and i=
n-band
+  ring tone management.
+
+  Complexity: C4
+  Priority: Medium
+  Depends: HFP AG emulator as BlueZ service
+
 PPP
 =3D=3D=3D
 =

-- =

1.7.1


--===============3580642441782587555==--

