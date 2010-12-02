Content-Type: multipart/mixed; boundary="===============0139940640526635990=="
MIME-Version: 1.0
From: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
Subject: [PATCH] doc: Add RoamingPreference property
Date: Thu, 02 Dec 2010 15:29:05 -0800
Message-ID: <1291332545-22888-2-git-send-email-Rajesh.Nagaiah@elektrobit.com>
In-Reply-To: <1291332545-22888-1-git-send-email-Rajesh.Nagaiah@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0139940640526635990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cdma-network-api.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/doc/cdma-network-api.txt b/doc/cdma-network-api.txt
index fd88d4e..62da5d8 100644
--- a/doc/cdma-network-api.txt
+++ b/doc/cdma-network-api.txt
@@ -68,3 +68,14 @@ Properties	string Status [readonly]
 		string Name [readonly, optional]
 =

 			Contains the name of the current network.
+
+		string RoamingPreference [readwrite]
+
+			Contains the roaming preference used in the network
+			selection.
+
+			The possible values are:
+				"home"        Home networks only
+				"roamonly"    Roaming networks only
+				"affiliated"  Affiliated networks only
+				"any"         Any network
-- =

1.7.0.4


--===============0139940640526635990==--

