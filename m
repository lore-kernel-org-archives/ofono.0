Content-Type: multipart/mixed; boundary="===============6522902609362431820=="
MIME-Version: 1.0
From: Andrew Earl <andrewx.earl@intel.com>
Subject: [PATCH 1/4] doc: Add subscriber number to handsfree-api
Date: Tue, 08 Apr 2014 09:21:44 +0100
Message-ID: <1396945307-12195-2-git-send-email-andrewx.earl@intel.com>
In-Reply-To: <1396945307-12195-1-git-send-email-andrewx.earl@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6522902609362431820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/handsfree-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
index 94e9a8f..5f45efb 100644
--- a/doc/handsfree-api.txt
+++ b/doc/handsfree-api.txt
@@ -76,3 +76,7 @@ Properties	array{string} Features [readonly]
 =

 			The current charge level of the battery.  The value
 			can be between 0 and 5 respectively.
+
+		array{string} SubscriberNumbers [readonly]
+
+			List of subscriber numbers provided by the AG.
-- =

1.7.11.7


--===============6522902609362431820==--

