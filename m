Content-Type: multipart/mixed; boundary="===============3960111642175202271=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/5] sim: Added new properties to simmanager for DSSA
Date: Thu, 28 Mar 2019 17:34:36 +0530
Message-ID: <1553774676-18183-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3960111642175202271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding two new properties to sim manager interface to handle
dual SIM single active use case.

CardSlotCount [readonly]
Contains the count of number of SIM card slots available.

ActiveCardSlot [readwrite]
Contains the index of the currently active SIM card slot
for dual SIM single active mode.
---
 doc/sim-api.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index bce47c1..c69cc74 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -205,3 +205,15 @@ Properties	boolean Present [readonly]
 =

 			Contains the SIM's ImsPrivateIdentity, read from the
 			ISIM.
+
+		uint32 CardSlotCount [readonly]
+
+			Contains the count of number of SIM card slots available.
+
+		uint32 ActiveCardSlot [readwrite]
+
+			Contains the index of the currently active SIM card slot
+			for dual SIM single active mode.
+
+			This property will range from 1 (default) to
+			CardSlotCount (max) value.
-- =

1.9.1


--===============3960111642175202271==--

