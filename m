Content-Type: multipart/mixed; boundary="===============2635207101481803451=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 1/5] doc: Add bearer property
Date: Fri, 02 Dec 2011 15:00:50 +0100
Message-ID: <1322834454-451-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1322834454-451-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2635207101481803451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cdma-connman-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
index 48699a3..bf1ec1e 100644
--- a/doc/cdma-connman-api.txt
+++ b/doc/cdma-connman-api.txt
@@ -35,6 +35,14 @@ Properties	boolean Powered [readwrite]
 			Contains whether the connection is dormant.  Will
 			always be false if the connection is not powered.
 =

+		string Bearer [readonly, optional]
+
+			Contains the data bearer technology as reported by the
+			service registration (if known).
+
+			Possible values are:
+			"none", "1x", "evdo", "svdo"
+
 		string Username [readwrite]
 =

 			Holds the username to be used for authentication
-- =

1.7.1


--===============2635207101481803451==--

