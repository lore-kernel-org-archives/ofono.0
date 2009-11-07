Content-Type: multipart/mixed; boundary="===============0130026075555615073=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/4] Add call_compare_by_phone_number utility function
Date: Sat, 07 Nov 2009 15:21:25 +0800
Message-ID: <1257578485.2888.12.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0130026075555615073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These 4 patches are small enhancements and bugs fixing for HFP voice
call driver.

It's used by HFP voicecall driver to compare two calls. In some
hardware, the call index may be shift when another call is released.
So we cannot use call index to update status.

For example, we have call #1 and call #2. When #1 is release, the
index of #2 decrease to 1. But we need index num 2 in the driver.
Otherwise, the core will be confused.
---
 drivers/atmodem/atutil.c |    9 +++++++++
 drivers/atmodem/atutil.h |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 26d0c25..687a466 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -67,6 +67,15 @@ gint at_util_call_compare_by_status(gconstpointer a,
gconstpointer b)
 	return 0;
 }
 =

+gint at_util_call_compare_by_phone_number(gconstpointer a,
gconstpointer b)
+{
+	const struct ofono_call *call =3D a;
+	const struct ofono_phone_number *pb =3D b;
+
+	return memcmp(&call->phone_number, pb,
+				sizeof(struct ofono_phone_number));
+}
+
 gint at_util_call_compare(gconstpointer a, gconstpointer b)
 {
 	const struct ofono_call *ca =3D a;
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 0444561..4ae1a27 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -22,6 +22,7 @@
 void decode_at_error(struct ofono_error *error, const char *final);
 void dump_response(const char *func, gboolean ok, GAtResult *result);
 gint at_util_call_compare_by_status(gconstpointer a, gconstpointer b);
+gint at_util_call_compare_by_phone_number(gconstpointer a,
gconstpointer b);
 gint at_util_call_compare(gconstpointer a, gconstpointer b);
 unsigned int at_util_alloc_next_id(unsigned int *id_list);
 void at_util_release_id(unsigned int *id_list, unsigned int id);
-- =

1.6.2.5




--===============0130026075555615073==--

