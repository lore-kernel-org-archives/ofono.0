Content-Type: multipart/mixed; boundary="===============3815482553069568641=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 10/20] sms_text_prepare: document @use_delivery_reports
Date: Fri, 23 Jul 2010 13:59:58 -0700
Message-ID: <6cc931db83455a66cbc6c85f34fbda053fc6e2cb.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3815482553069568641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/smsutil.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 969c1b7..3ca5979 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2831,6 +2831,9 @@ static inline GSList *sms_list_append(GSList *l, cons=
t struct sms *in)
  * Returns a list of sms messages in order.  If ref_offset is given,
  * then the ref_offset contains the reference number offset or 0
  * if no concatenation took place.
+ *
+ * @use_delivery_reports: value for the Status-Report-Request field
+ *     (23.040 3.2.9, 9.2.2.2)
  */
 GSList *sms_text_prepare(const char *utf8, guint16 ref,
 				gboolean use_16bit, int *ref_offset,
-- =

1.6.6.1


--===============3815482553069568641==--

