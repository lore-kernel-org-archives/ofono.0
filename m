Content-Type: multipart/mixed; boundary="===============1780747895620410576=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 10/20] doc: add PreferredMode property to modem
Date: Mon, 11 Apr 2011 13:20:08 +0300
Message-ID: <1302517218-2147-11-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1780747895620410576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/modem-api.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index fa400a2..c79bffa 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -54,6 +54,24 @@ Properties	boolean Powered [readwrite]
 			modem. The Emergency is true if an emergency call or
 			related operation is currently active.
 =

+		string PreferredMode [readonly, optional]
+
+			Preferred UE mode setting. A UE attached for EPS services
+			shall operate in one of the following operation modes:
+
+				"PS mode 2"	UE registers only to EPS
+						services, and UE's usage setting
+						is "data centric".
+				"CS/PS mode 1"	UE registers to both EPS and
+						non-EPS services, and UE's usage
+						setting is "voice centric".
+				"CS/PS mode 2"	UE registers to both EPS and
+						non-EPS services, and UE's usage
+						setting is "data centric".
+				"PS mode 1"	UE registers only to EPS
+						services, and UE's usage setting
+						is "voice centric".
+
 		string Name [readonly, optional]
 =

 			Friendly name of the modem device.
-- =

1.7.0.4


--===============1780747895620410576==--

