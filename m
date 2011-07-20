Content-Type: multipart/mixed; boundary="===============6503452059867437625=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2] TODO: add HFP 1.6 AG tasks
Date: Wed, 20 Jul 2011 15:58:50 +0200
Message-ID: <1311170330-6070-1-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1311170102-5877-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6503452059867437625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 8302f6f..b464b19 100644
--- a/TODO
+++ b/TODO
@@ -132,6 +132,20 @@ Modem Emulator
   Complexity: C4
   Priority: Medium
 =

+- Support new HFP 1.6 AG command related to indicators (AT+BIA).
+
+  Complexity: C1
+  Priority: Low
+  Owner: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com>
+  Depends: HFP AG emulator
+
+- Support new HFP 1.6 AG commands allowing to publish, select and connect =
audio
+  codecs (AT+BAC, AT+BCS, +BCS, AT+BCC). This will need to interact with a=
udio
+  framework.
+
+  Complexity: C4
+  Priority: Low
+  Depends: HFP AG emulator
 =

 PPP
 =3D=3D=3D
-- =

1.7.1


--===============6503452059867437625==--

