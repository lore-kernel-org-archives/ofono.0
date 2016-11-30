Content-Type: multipart/mixed; boundary="===============4919140862507330641=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH 1/7] netmon: add OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP}
Date: Wed, 30 Nov 2016 13:13:16 +0100
Message-ID: <1480508002-15830-2-git-send-email-djalal@endocode.com>
In-Reply-To: <1480508002-15830-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4919140862507330641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add more ofono netmon info types that will be served through the netmon
interface. The main user of this now will be the ublox modem.

RSCP: Received Signal Code Power
ECN0: Received Energy Ratio
RSRQ: Reference Signal Received Quality
RSRP: Reference Signal Received Power

Patches using these types to follow.
---
 include/netmon.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/netmon.h b/include/netmon.h
index ec8a2e1..47d7a9c 100644
--- a/include/netmon.h
+++ b/include/netmon.h
@@ -59,6 +59,10 @@ enum ofono_netmon_info {
 	OFONO_NETMON_INFO_RSSI, /* int */
 	OFONO_NETMON_INFO_TIMING_ADVANCE, /* int */
 	OFONO_NETMON_INFO_PSC, /* int */
+	OFONO_NETMON_INFO_RSCP, /* int */
+	OFONO_NETMON_INFO_ECN0, /* int */
+	OFONO_NETMON_INFO_RSRQ, /* int */
+	OFONO_NETMON_INFO_RSRP, /* int */
 	OFONO_NETMON_INFO_INVALID,
 };
 =

-- =

2.5.5


--===============4919140862507330641==--

