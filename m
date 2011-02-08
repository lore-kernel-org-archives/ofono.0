Content-Type: multipart/mixed; boundary="===============4594222394844380561=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH] doc: Rename CDMA DataStrength to EVDOStrength
Date: Tue, 08 Feb 2011 13:46:19 -0800
Message-ID: <1297201579-3139-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4594222394844380561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Current terminology is misleading as Data is possible over both
1xRTT and 1xEV-DO, i.e. either of the signal stengths being
reported could correspond to a currently active traffic channel.

EV-DO terminology replaces references to High Data Rate (HDR),
according to global standard and to common carrier convention to
omit the 1x prefix.
---
 doc/cdma-network-api.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/cdma-network-api.txt b/doc/cdma-network-api.txt
index 62da5d8..cfc15a5 100644
--- a/doc/cdma-network-api.txt
+++ b/doc/cdma-network-api.txt
@@ -41,11 +41,11 @@ Properties	string Status [readonly]
 			Contains the current signal strength as a percentage
 			between 0-100 percent.
 =

-		byte DataStrength [readonly]
+		byte EVDOStrength [readonly]
 =

-			Contains the current signal strength of the High Data
-			Rate network.  This is a percentage value between
-			0-100 percent.
+			Contains the current signal strength of the Evolution
+			Data Optimised network.  This is a percentage value
+			between 0-100 percent.
 =

 		uint16 SystemIdentifier [readonly, optional]
 =

-- =

1.7.0.4


--===============4594222394844380561==--

