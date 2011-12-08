Content-Type: multipart/mixed; boundary="===============4959157561142019831=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/3] TODO: Split in 2 tasks RSSI and Ec/Io measurement
Date: Thu, 08 Dec 2011 10:58:17 +0100
Message-ID: <1323338298-4625-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323338298-4625-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4959157561142019831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/TODO b/TODO
index 63d28ab..0b25806 100644
--- a/TODO
+++ b/TODO
@@ -508,7 +508,12 @@ CDMA Network Acquisition
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

 - Support reporting of the received signal strength indicator (RSSI)
-  measurement and of the pilot energy ratio (Ec/Io) measurement, for the
+  measurement for the currently acquired CDMA network.
+
+  Priority: Medium
+  Complexity: C1
+
+- Support reporting of the pilot energy ratio (Ec/Io) measurement for the
   currently acquired CDMA network.
 =

   Priority: Medium
-- =

1.7.1


--===============4959157561142019831==--

