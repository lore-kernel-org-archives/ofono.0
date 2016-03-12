Content-Type: multipart/mixed; boundary="===============2407182777008308817=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 2/3] gprs: add api for reading access technology
Date: Sat, 12 Mar 2016 15:51:31 +0100
Message-ID: <1457794292-21184-3-git-send-email-dragos@endocode.com>
In-Reply-To: <1457794292-21184-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2407182777008308817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Result forwarded from network.c.
---
 src/gprs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 9192e68..d9c0fe5 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -3248,3 +3248,8 @@ void *ofono_gprs_get_data(struct ofono_gprs *gprs)
 {
 	return gprs->driver_data;
 }
+
+int ofono_gprs_get_technology(struct ofono_gprs *gprs)
+{
+	return ofono_netreg_get_technology(gprs->netreg);
+}
-- =

2.5.0


--===============2407182777008308817==--

