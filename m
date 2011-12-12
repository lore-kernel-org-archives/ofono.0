Content-Type: multipart/mixed; boundary="===============5310779798641206401=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/2] TODO: Split in 2 tasks RSSI and SINR measurement
Date: Mon, 12 Dec 2011 10:17:26 +0100
Message-ID: <1323681447-2962-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5310779798641206401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/TODO b/TODO
index df3b422..53277a5 100644
--- a/TODO
+++ b/TODO
@@ -514,8 +514,13 @@ CDMA Network Acquisition
   Complexity: C1
 =

 - Support reporting of the received signal strength indicator (RSSI)
-  measurement and of the signal to interference-plus-noise ratio (SINR)
-  measurement, for the currently acquired 1xEV-DO data network.
+  measurement for the currently acquired 1xEV-DO data network.
+
+  Priority: Medium
+  Complexity: C1
+
+- Support of the signal to interference-plus-noise ratio (SINR)
+  measurement for the currently acquired 1xEV-DO data network.
 =

   Priority: Medium
   Complexity: C1
-- =

1.7.1


--===============5310779798641206401==--

