Content-Type: multipart/mixed; boundary="===============5474482809188120412=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 01/12] TODO: Task added for HFP-specific capabilities
Date: Thu, 15 Sep 2011 18:34:32 +0200
Message-ID: <1316104483-13144-2-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1316104483-13144-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5474482809188120412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 6d791ac..d5a6de3 100644
--- a/TODO
+++ b/TODO
@@ -117,6 +117,17 @@ SIM / SIM File system
   Complexity: C1
 =

 =

+Bluetooth HFP
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Support HFP-specific AT commands for the HF role, providing an appropria=
te
+  D-Bus API when needed. Some examples are AT+BIA, AT+BINP, AT+BLDN, AT+BV=
RA,
+  AT+BRSF, etc.
+
+  Priority: Medium
+  Complexity: C2
+
+
 Modem Emulator
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.6


--===============5474482809188120412==--

