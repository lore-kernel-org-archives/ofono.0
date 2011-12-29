Content-Type: multipart/mixed; boundary="===============6266580508771273577=="
MIME-Version: 1.0
From: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH] atutil: Fix newline before EOF and coding guideline volation
Date: Fri, 30 Dec 2011 04:28:01 +0530
Message-ID: <1325199481-27598-1-git-send-email-syamsidhardh@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6266580508771273577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 26817e2..5046547 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -131,5 +131,4 @@ static inline int at_util_convert_signal_strength(int s=
trength)
 		e.type =3D OFONO_ERROR_TYPE_NO_ERROR;	\
 		e.error =3D 0;				\
 		f(&e, ##args);				\
-	} while(0)					\
-
+	} while (0)
-- =

1.7.4.1


--===============6266580508771273577==--

