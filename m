Content-Type: multipart/mixed; boundary="===============3752185235681107263=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 1/6] doc: Add DormantInterval property
Date: Wed, 07 Dec 2011 17:05:46 +0100
Message-ID: <1323273951-24162-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323273951-24162-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3752185235681107263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cdma-connman-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
index 48699a3..a6d1e56 100644
--- a/doc/cdma-connman-api.txt
+++ b/doc/cdma-connman-api.txt
@@ -35,6 +35,11 @@ Properties	boolean Powered [readwrite]
 			Contains whether the connection is dormant.  Will
 			always be false if the connection is not powered.
 =

+		int DormantInterval [readwrite]
+
+			Contains the interval in seconds to enter in dormant
+			Mode.
+
 		string Username [readwrite]
 =

 			Holds the username to be used for authentication
-- =

1.7.1


--===============3752185235681107263==--

