Content-Type: multipart/mixed; boundary="===============0782041654759090973=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/6] doc: Add RoamingAllowed property
Date: Wed, 02 Nov 2011 11:37:57 +0100
Message-ID: <1320230281-20743-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320230281-20743-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0782041654759090973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cdma-connman-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
index 48699a3..e4d3d2f 100644
--- a/doc/cdma-connman-api.txt
+++ b/doc/cdma-connman-api.txt
@@ -35,6 +35,14 @@ Properties	boolean Powered [readwrite]
 			Contains whether the connection is dormant.  Will
 			always be false if the connection is not powered.
 =

+		boolean RoamingAllowed [readwrite]
+
+			Contains whether data roaming is allowed.  In the off
+			setting, if the packet radio registration state
+			indicates that the modem is roaming, oFono will
+			automatically disable connection and no further
+			connection establishment will be possible.
+
 		string Username [readwrite]
 =

 			Holds the username to be used for authentication
-- =

1.7.1


--===============0782041654759090973==--

