Content-Type: multipart/mixed; boundary="===============7873746352863208605=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 01/10] service: remove files when unable to decode received
 msg
Date: Fri, 13 Apr 2012 18:33:40 +0200
Message-ID: <1334334829-31617-2-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7873746352863208605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Ronald Tessier <ronald.tessier@linux.intel.com>

---
 src/service.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index f148252..593adcb 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1019,6 +1019,9 @@ out:
 =

 	mms_store_meta_close(service_id, uuid, meta, FALSE);
 =

+	if (success =3D=3D FALSE)
+		mms_store_remove(service_id, uuid);
+
 	return success;
 }
 =

-- =

1.7.4.4


--===============7873746352863208605==--

