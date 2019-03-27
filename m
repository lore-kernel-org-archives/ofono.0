Content-Type: multipart/mixed; boundary="===============8865932426028979310=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/6] sim: Added new properties to simmanager for DSSA
Date: Wed, 27 Mar 2019 17:39:12 +0530
Message-ID: <1553688552-22144-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8865932426028979310==
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


--===============8865932426028979310==--

