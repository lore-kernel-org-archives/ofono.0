Content-Type: multipart/mixed; boundary="===============2124168143801532415=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 04/10] service: add attempts counter variable
Date: Fri, 13 Apr 2012 18:33:43 +0200
Message-ID: <1334334829-31617-5-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2124168143801532415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index 7969988..a4f236b 100644
--- a/src/service.c
+++ b/src/service.c
@@ -55,6 +55,7 @@
 #define CONTENT_TYPE_APP_SMIL "Content-Type: \"application/smil\";charset=
=3Dutf-8"
 =

 #define MAX_ATTACHMENTS_NUMBER 25
+#define MAX_ATTEMPTS 3
 =

 #define uninitialized_var(x) x =3D x
 =

@@ -98,6 +99,7 @@ struct mms_request {
 	gsize data_size;
 	int fd;
 	guint16 status;
+	guint16 attempt;
 	struct mms_service *service;
 	mms_request_result_cb_t result_cb;
 	struct mms_message *msg;
@@ -526,6 +528,8 @@ static struct mms_request *create_request(enum mms_requ=
est_type type,
 =

 	request->status =3D 0;
 =

+	request->attempt =3D 0;
+
 	return request;
 }
 =

-- =

1.7.4.4


--===============2124168143801532415==--

