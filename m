Content-Type: multipart/mixed; boundary="===============2325187556769237797=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 2/4] qmimodem: add define CALLBACK_WITH_CME_ERROR(cb, err,
 args..)
Date: Tue, 05 Dec 2017 19:20:15 +0100
Message-ID: <20171205182017.462-2-lynxis@fe80.eu>
In-Reply-To: <20171205182017.462-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2325187556769237797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/util.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/qmimodem/util.h b/drivers/qmimodem/util.h
index cf053f0fe840..974160234af5 100644
--- a/drivers/qmimodem/util.h
+++ b/drivers/qmimodem/util.h
@@ -39,6 +39,15 @@ static inline struct cb_data *cb_data_new(void *cb, void=
 *data)
 	return ret;
 }
 =

+#define CALLBACK_WITH_CME_ERROR(cb, err, args...)	\
+	do {						\
+		struct ofono_error cb_e;		\
+		cb_e.type =3D OFONO_ERROR_TYPE_CME;	\
+		cb_e.error =3D err;			\
+							\
+		cb(&cb_e, ##args);			\
+	} while (0)					\
+
 #define CALLBACK_WITH_FAILURE(cb, args...)		\
 	do {						\
 		struct ofono_error cb_e;		\
-- =

2.15.1


--===============2325187556769237797==--

