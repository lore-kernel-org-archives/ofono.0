Content-Type: multipart/mixed; boundary="===============7415578037869516399=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [PATCH 1/6] STE-plugin: Add at_util_call_compare_by_id
Date: Mon, 25 Jan 2010 20:25:28 +0100
Message-ID: <1264447534-2386-2-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1264447534-2386-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7415578037869516399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add function at_util_call_compare_by_phone_number() to atutil.c

---
 drivers/atmodem/atutil.c |   14 ++++++++++++++
 drivers/atmodem/atutil.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index ab52999..28a192a 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -77,6 +77,20 @@ gint at_util_call_compare_by_phone_number(gconstpointer =
a, gconstpointer b)
 				sizeof(struct ofono_phone_number));
 }
 =

+gint at_util_call_compare_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *call =3D a;
+	unsigned int id =3D GPOINTER_TO_UINT(b);
+
+	if (id < call->id)
+		return -1;
+
+	if (id > call->id)
+		return 1;
+
+	return 0;
+}
+
 gint at_util_call_compare(gconstpointer a, gconstpointer b)
 {
 	const struct ofono_call *ca =3D a;
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 0ab207d..fc5b041 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -23,6 +23,7 @@ void decode_at_error(struct ofono_error *error, const cha=
r *final);
 void dump_response(const char *func, gboolean ok, GAtResult *result);
 gint at_util_call_compare_by_status(gconstpointer a, gconstpointer b);
 gint at_util_call_compare_by_phone_number(gconstpointer a, gconstpointer b=
);
+gint at_util_call_compare_by_id(gconstpointer a, gconstpointer b);
 gint at_util_call_compare(gconstpointer a, gconstpointer b);
 GSList *at_util_parse_clcc(GAtResult *result);
 gboolean at_util_parse_reg(GAtResult *result, const char *prefix,
-- =

1.6.0.4


--===============7415578037869516399==--

