Content-Type: multipart/mixed; boundary="===============2450025893018512989=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH] cbs: Resolve a use-after-free that could occur with rapid
 location changes.
Date: Mon, 21 Dec 2015 10:03:49 +0000
Message-ID: <1450692250-29422-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2450025893018512989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

What happens is that the timeout leaks and then the cbs struct with
the callback is cleaned up, resulting in a SIGSEGV when the callback
occurs from the glib loop.
---
 src/cbs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/cbs.c b/src/cbs.c
index b5f0b72..fdc44a1 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -1029,11 +1029,14 @@ out:
 =

 	/*
 	 * In order to minimize signal transmissions we wait about X seconds
-	 * before reseting the base station id.  The hope is that we receive
+	 * before resetting the base station id.  The hope is that we receive
 	 * another cell broadcast with the new base station name within
 	 * that time
 	 */
 	if (lac_changed || ci_changed) {
+		if(cbs->reset_source)
+			g_source_remove(cbs->reset_source);
+
 		cbs->reset_source =3D
 			g_timeout_add_seconds(3, reset_base_station_name, cbs);
 	}
-- =

1.9.1

--===============2450025893018512989==--

