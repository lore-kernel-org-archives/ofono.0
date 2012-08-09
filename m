Content-Type: multipart/mixed; boundary="===============6492187517743614377=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 2/3] doc: Describe GetProperties in service-api
Date: Thu, 09 Aug 2012 17:51:42 +0200
Message-ID: <1344527503-9965-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1344527503-9965-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6492187517743614377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/service-api.txt |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/service-api.txt b/doc/service-api.txt
index 25f2d0d..1bf820e 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -36,6 +36,13 @@ Methods		array{object,dict} GetMessages()
 			Possible Errors: [service].Error.InvalidArguments
 					 [service].Error.TransientFailure
 =

+		dict GetProperties()
+
+			Returns properties for the manager object. See
+			the properties section for available properties.
+
+			Possible Errors: [service].Error.NotImplemented
+
 		object SendMessage(array{string} recipients, string smil,
 					array{string id, string content-type,
 							string filename})
-- =

1.7.9.5


--===============6492187517743614377==--

