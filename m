Content-Type: multipart/mixed; boundary="===============2920106267064566490=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] TODO: add HFP 1.6 AG tasks
Date: Wed, 20 Jul 2011 15:55:02 +0200
Message-ID: <1311170102-5877-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2920106267064566490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 8302f6f..4530407 100644
--- a/TODO
+++ b/TODO
@@ -132,6 +132,18 @@ Modem Emulator
   Complexity: C4
   Priority: Medium
 =

+- Support new HFP 1.6 AG command related to indicators (AT+BIA).
+
+  Complexity: C1
+  Priority: Low
+  Owner: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com>
+
+- Support new HFP 1.6 AG commands allowing to publish, select and connect =
audio
+  codecs (AT+BAC, AT+BCS, +BCS, AT+BCC). This will need to interact with a=
udio
+  framework.
+
+  Complexity: C4
+  Priority: Low
 =

 PPP
 =3D=3D=3D
-- =

1.7.1


--===============2920106267064566490==--

