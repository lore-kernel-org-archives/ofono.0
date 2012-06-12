Content-Type: multipart/mixed; boundary="===============8622310540636549824=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 2/6] doc: Modify SendMessage D-Bus API
Date: Tue, 12 Jun 2012 16:04:11 +0200
Message-ID: <1339509855-7467-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1339509855-7467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8622310540636549824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/service-api.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/doc/service-api.txt b/doc/service-api.txt
index 36e1161..57e8942 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -36,7 +36,8 @@ Methods		array{object,dict} GetMessages()
 			Possible Errors: [service].Error.InvalidArguments
 					 [service].Error.TransientFailure
 =

-		object SendMessage(array{string} recipients, string smil,
+		object SendMessage(array{string} recipients,
+					boolean delivery-report, string smil,
 					array{string id, string content-type,
 							string filename})
 =

-- =

1.7.4.1


--===============8622310540636549824==--

