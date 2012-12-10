Content-Type: multipart/mixed; boundary="===============7465026389559656596=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] atutil: Remove unused macro
Date: Mon, 10 Dec 2012 11:37:19 +0100
Message-ID: <1355135839-27306-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7465026389559656596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

With commit 6ee21a3fc18460cc12dbddb3b7ec70e941fa4bbc
the usage DECLARE_FAILURE was removed.
---
 drivers/atmodem/atutil.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index b17a4a5..48b9b0d 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -112,11 +112,6 @@ static inline int at_util_convert_signal_strength(int =
strength)
 	return result;
 }
 =

-#define DECLARE_FAILURE(e) 			\
-	struct ofono_error e;			\
-	e.type =3D OFONO_ERROR_TYPE_FAILURE;	\
-	e.error =3D 0				\
-
 #define CALLBACK_WITH_FAILURE(cb, args...)		\
 	do {						\
 		struct ofono_error cb_e;		\
-- =

1.8.0.rc0


--===============7465026389559656596==--

