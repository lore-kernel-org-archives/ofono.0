Content-Type: multipart/mixed; boundary="===============5711121549073877507=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 1/3] include: Add OFONO_ERROR_TYPE_ERRNO
Date: Thu, 28 Jun 2018 19:30:58 +0300
Message-ID: <1530203460-20552-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5711121549073877507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/types.h b/include/types.h
index 2c64b20..90d8c2c 100644
--- a/include/types.h
+++ b/include/types.h
@@ -56,6 +56,7 @@ enum ofono_error_type {
 	OFONO_ERROR_TYPE_CEER,
 	OFONO_ERROR_TYPE_SIM,
 	OFONO_ERROR_TYPE_FAILURE,
+	OFONO_ERROR_TYPE_ERRNO
 };
 =

 enum ofono_disconnect_reason {
-- =

1.9.1


--===============5711121549073877507==--

