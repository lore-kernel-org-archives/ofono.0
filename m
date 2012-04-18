Content-Type: multipart/mixed; boundary="===============6540900683309408949=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv3 05/10] service: move destroy request into process_request
Date: Wed, 18 Apr 2012 15:27:43 +0200
Message-ID: <1334755668-27458-6-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1334755668-27458-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6540900683309408949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>

To make it possible to be re-queued
---
 src/service.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 4c8a87e..efb90cb 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1913,6 +1913,8 @@ static guint process_request(struct mms_request *requ=
est)

 	unlink(request->data_path);

+	mms_request_destroy(request);
+
 	return 0;
 }

@@ -1940,8 +1942,6 @@ static void process_request_queue(struct mms_service =
*service)
 		service->current_request_id =3D process_request(request);
 		if (service->current_request_id > 0)
 			return;
-
-		mms_request_destroy(request);
 	}

 	service->bearer_timeout =3D g_timeout_add_seconds(BEARER_IDLE_TIMEOUT,
--
1.7.4.1


--===============6540900683309408949==--

