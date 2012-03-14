Content-Type: multipart/mixed; boundary="===============1403358803127114243=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 1/1] service: remove unused mms_request's members
Date: Wed, 14 Mar 2012 11:46:02 +0100
Message-ID: <1331721962-5843-5-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1331721962-5843-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1403358803127114243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 4ad9d39..14b5284 100644
--- a/src/service.c
+++ b/src/service.c
@@ -96,8 +96,6 @@ struct mms_request {
 	char *data_path;
 	char *location;
 	gsize data_size;
-	gpointer data;
-	gsize offset;
 	int fd;
 	guint16 status;
 	struct mms_service *service;
--
1.7.4.1


--===============1403358803127114243==--

