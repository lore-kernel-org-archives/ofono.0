Content-Type: multipart/mixed; boundary="===============5539381345334078388=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 05/10] service: move destroy request into process_request
Date: Fri, 13 Apr 2012 18:33:44 +0200
Message-ID: <1334334829-31617-6-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5539381345334078388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To make it possible to be re-queued
---
 src/service.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index a4f236b..ee06dca 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1911,6 +1911,8 @@ static guint process_request(struct mms_request *requ=
est)
 =

 	unlink(request->data_path);
 =

+	mms_request_destroy(request);
+
 	return 0;
 }
 =

@@ -1938,8 +1940,6 @@ static void process_request_queue(struct mms_service =
*service)
 		service->current_request_id =3D process_request(request);
 		if (service->current_request_id > 0)
 			return;
-
-		mms_request_destroy(request);
 	}
 =

 	service->bearer_timeout =3D g_timeout_add_seconds(BEARER_IDLE_TIMEOUT,
-- =

1.7.4.4


--===============5539381345334078388==--

