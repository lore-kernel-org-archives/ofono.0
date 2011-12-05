Content-Type: multipart/mixed; boundary="===============7160822272704738309=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 1/2] doc: Add RoamingAllowed property
Date: Mon, 05 Dec 2011 15:04:16 +0100
Message-ID: <1323093857-28071-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323093857-28071-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7160822272704738309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cdma-connman-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
index 48699a3..4f025a9 100644
--- a/doc/cdma-connman-api.txt
+++ b/doc/cdma-connman-api.txt
@@ -45,6 +45,14 @@ Properties	boolean Powered [readwrite]
 			Holds the password to be used for authentication
 			purposes.
 =

+		boolean RoamingAllowed [readwrite]
+
+			Contains whether data roaming is allowed.  In the off
+			setting, if the packet radio registration state
+			indicates that the modem is roaming, oFono will
+			prevent any data call. However it won't stop any
+			already dialed data call.
+
 		dict Settings [readonly, optional]
 =

 			Holds all the IP network settings
-- =

1.7.1


--===============7160822272704738309==--

