Content-Type: multipart/mixed; boundary="===============2339038487534937967=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 03/10] Update access technology documentation
Date: Mon, 10 Jan 2011 15:15:18 +0200
Message-ID: <1294665325-11937-3-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201101101515.04596.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2339038487534937967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-api.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 4616542..28304e3 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -125,8 +125,9 @@ Properties	string Mode [readonly]
 =

 			Contains the technology of the current network.
 =

-			The possible values are: "gsm", "edge", "umts", "hspa",
-							"lte"
+			The possible values are: "gsm", "edge", "umts",
+			"hsdpa", "hsupa", "hspa" (meaning both hsdpa and hsupa)
+			and "lte"
 =

 			TODO: Values for CDMA and EVDO based networks.
 =

-- =

1.7.1


--===============2339038487534937967==--

