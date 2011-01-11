Content-Type: multipart/mixed; boundary="===============4675464679982500696=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 03/11] Update access network technology property values
Date: Tue, 11 Jan 2011 16:08:31 +0200
Message-ID: <1294754919-9687-3-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294754919-9687-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4675464679982500696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-api.txt |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 4616542..a9d341c 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -125,8 +125,7 @@ Properties	string Mode [readonly]
 =

 			Contains the technology of the current network.
 =

-			The possible values are: "gsm", "edge", "umts", "hspa",
-							"lte"
+			The possible values are: "gsm", "umts" and "lte"
 =

 			TODO: Values for CDMA and EVDO based networks.
 =

@@ -210,8 +209,7 @@ Properties	string Name [readonly]
 			Contains a list of technologies currently available
 			from this network provider.
 =

-			The possible values are: "gsm", "edge", "umts", "hspa",
-							"lte"
+			The possible values are: "gsm", "umts" and "lte"
 =

 		string AdditionalInformation [readonly, optional]
 =

-- =

1.7.1


--===============4675464679982500696==--

