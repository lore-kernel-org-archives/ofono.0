Content-Type: multipart/mixed; boundary="===============8984017835307032138=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/2] TODO: Mark RSSI task for 1xEVDO as done
Date: Mon, 12 Dec 2011 10:17:27 +0100
Message-ID: <1323681447-2962-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323681447-2962-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8984017835307032138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    6 ------
 doc/features.txt |    3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/TODO b/TODO
index 53277a5..46dadce 100644
--- a/TODO
+++ b/TODO
@@ -513,12 +513,6 @@ CDMA Network Acquisition
   Priority: Medium
   Complexity: C1
 =

-- Support reporting of the received signal strength indicator (RSSI)
-  measurement for the currently acquired 1xEV-DO data network.
-
-  Priority: Medium
-  Complexity: C1
-
 - Support of the signal to interference-plus-noise ratio (SINR)
   measurement for the currently acquired 1xEV-DO data network.
 =

diff --git a/doc/features.txt b/doc/features.txt
index 2bca0c7..74f1b02 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -696,3 +696,6 @@ CDMA Network Acquisition
 =

 - Support reporting of the received signal strength indicator (RSSI)
   measurement for the currently acquired CDMA network.
+
+- Support reporting of the received signal strength indicator (RSSI)
+  measurement for the currently acquired 1xEV-DO data network.
-- =

1.7.1


--===============8984017835307032138==--

