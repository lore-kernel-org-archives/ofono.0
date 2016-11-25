Content-Type: multipart/mixed; boundary="===============4107926680740033802=="
MIME-Version: 1.0
From: djalal@endocode.com
Subject: [PATCH 1/5] netmon: add
 OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR}
Date: Fri, 25 Nov 2016 15:00:11 +0100
Message-ID: <1480082415-30822-2-git-send-email-djalal@endocode.com>
In-Reply-To: <1480082415-30822-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4107926680740033802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Djalal Harouni <djalal@endocode.com>

Add more ofono netmon info types that will be served through the netmon
interface. The main user of this now will be the ublox modem.

RSCP: Received Signal Code Power
ECN0: Received Energy Ratio
RSRQ: Reference Signal Received Quality
RSRP: Reference Signal Received Power
OPERATOR: the operator

Patches using these types to follow.
---
 include/netmon.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/netmon.h b/include/netmon.h
index ec8a2e1..abde225 100644
--- a/include/netmon.h
+++ b/include/netmon.h
@@ -59,6 +59,11 @@ enum ofono_netmon_info {
 	OFONO_NETMON_INFO_RSSI, /* int */
 	OFONO_NETMON_INFO_TIMING_ADVANCE, /* int */
 	OFONO_NETMON_INFO_PSC, /* int */
+	OFONO_NETMON_INFO_RSCP, /* int */
+	OFONO_NETMON_INFO_ECN0, /* int */
+	OFONO_NETMON_INFO_RSRQ, /* int */
+	OFONO_NETMON_INFO_RSRP, /* int */
+	OFONO_NETMON_INFO_OPERATOR, /* char *, up to 24 digits */
 	OFONO_NETMON_INFO_INVALID,
 };
 =

-- =

2.5.5


--===============4107926680740033802==--

