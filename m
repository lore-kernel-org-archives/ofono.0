Content-Type: multipart/mixed; boundary="===============8852907995753356006=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [RFC PATCH 1/3] types: change OFONO_MAX_PHONE_NUMBER_LENGTH value to
 80
Date: Mon, 17 Jan 2011 11:59:26 -0300
Message-ID: <1295276368-32233-2-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1295276368-32233-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8852907995753356006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/types.h b/include/types.h
index 1b95eaa..e4951e4 100644
--- a/include/types.h
+++ b/include/types.h
@@ -76,7 +76,7 @@ struct ofono_error {
 	int error;
 };
 =

-#define OFONO_MAX_PHONE_NUMBER_LENGTH 20
+#define OFONO_MAX_PHONE_NUMBER_LENGTH 80
 #define OFONO_MAX_CALLER_NAME_LENGTH 80
 =

 struct ofono_phone_number {
-- =

1.7.2.3


--===============8852907995753356006==--

