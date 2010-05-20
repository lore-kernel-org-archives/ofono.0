Content-Type: multipart/mixed; boundary="===============6885436217574040104=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v4 2/3] Move report_signal_strength to atutil
Date: Thu, 20 May 2010 11:04:14 +0300
Message-ID: <20100520080414.17288.40729.stgit@potku.valot.fi>
In-Reply-To: <20100520080214.17288.7485.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6885436217574040104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function is needed in two different places, better to move it
to atutil.h.
---

 drivers/atmodem/atutil.h               |   12 ++++++++++++
 drivers/atmodem/network-registration.c |    4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 9303ed4..265a5ad 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -55,6 +55,18 @@ static inline struct cb_data *cb_data_new(void *cb, void=
 *data)
 	return ret;
 }
 =

+static inline int at_util_convert_signal_strength(int strength)
+{
+	int result;
+
+	if (strength =3D=3D 99)
+		result =3D -1;
+	else
+		result =3D (strength * 100) / 31;
+
+	return result;
+}
+
 #define DECLARE_FAILURE(e) 			\
 	struct ofono_error e;			\
 	e.type =3D OFONO_ERROR_TYPE_FAILURE;	\
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index f7aafbe..ff94160 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -473,7 +473,6 @@ static inline void report_signal_strength(struct ofono_=
netreg *netreg,
 	else
 		strength =3D (strength * 100) / 31;
 =

-	ofono_netreg_strength_notify(netreg, strength);
 }
 =

 static void csq_notify(GAtResult *result, gpointer user_data)
@@ -490,7 +489,8 @@ static void csq_notify(GAtResult *result, gpointer user=
_data)
 	if (!g_at_result_iter_next_number(&iter, &strength))
 		return;
 =

-	report_signal_strength(netreg, strength);
+	ofono_netreg_strength_notify(netreg,
+				at_util_convert_signal_strength(strength));
 }
 =

 static void calypso_csq_notify(GAtResult *result, gpointer user_data)


--===============6885436217574040104==--

