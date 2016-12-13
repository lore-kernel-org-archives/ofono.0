Content-Type: multipart/mixed; boundary="===============0231041174351926613=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH 1/5] netmon: add NETMON_INFO_{EARFCN|EBAND|CQI}
Date: Tue, 13 Dec 2016 12:05:24 +0100
Message-ID: <1481627128-20233-2-git-send-email-djalal@endocode.com>
In-Reply-To: <1481627128-20233-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0231041174351926613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the following types to use with ublox modems +UCGED command.

EARFCN: E-UTRA Absolute Radio Frequency Channel Number.
EBand: E-UTRA operating Band.
CQI: Channel Quality Indicator.
---
 include/netmon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/netmon.h b/include/netmon.h
index 47d7a9c..72090c3 100644
--- a/include/netmon.h
+++ b/include/netmon.h
@@ -63,6 +63,9 @@ enum ofono_netmon_info {
 	OFONO_NETMON_INFO_ECN0, /* int */
 	OFONO_NETMON_INFO_RSRQ, /* int */
 	OFONO_NETMON_INFO_RSRP, /* int */
+	OFONO_NETMON_INFO_EARFCN, /* int */
+	OFONO_NETMON_INFO_EBAND, /* int */
+	OFONO_NETMON_INFO_CQI, /* int */
 	OFONO_NETMON_INFO_INVALID,
 };
 =

-- =

2.5.5


--===============0231041174351926613==--

