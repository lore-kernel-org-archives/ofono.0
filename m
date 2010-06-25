Content-Type: multipart/mixed; boundary="===============7080845763548519040=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 03/23] smutil.h: add missing header file dependencies
Date: Fri, 25 Jun 2010 16:15:25 -0700
Message-ID: <7356379c8adb4d93335cae5e9ab75d0684b93321.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7080845763548519040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/smsutil.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/smsutil.h b/src/smsutil.h
index 66ef6f8..baa3eca 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -18,6 +18,14 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
  */
+#ifndef __smsutil_h__
+#define __smsutil_h__
+
+#include <time.h>
+#include <glib/gtypes.h>
+#include <glib/gslist.h>
+#include <glib/gmessages.h>
+#include <glib/gchecksum.h>
 =

 #define CBS_MAX_GSM_CHARS 93
 =

@@ -539,3 +547,4 @@ GSList *cbs_optimize_ranges(GSList *ranges);
 gboolean cbs_topic_in_range(unsigned int topic, GSList *ranges);
 =

 char *ussd_decode(int dcs, int len, const unsigned char *data);
+#endif /* #ifndef __smsutil_h__ */
-- =

1.6.6.1


--===============7080845763548519040==--

