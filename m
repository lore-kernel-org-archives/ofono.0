Content-Type: multipart/mixed; boundary="===============8197697726313674882=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [RFC patches 06/13] smutil.h: add missing header file dependencies
Date: Wed, 26 May 2010 12:49:20 -0700
Message-ID: <4304def8734a39650175fd6765317d1c70b0beba.1274903142.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8197697726313674882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/smsutil.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/smsutil.h b/src/smsutil.h
index 469a49e..356ec5d 100644
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

@@ -501,3 +509,5 @@ char *cbs_topic_ranges_to_string(GSList *ranges);
 GSList *cbs_extract_topic_ranges(const char *ranges);
 GSList *cbs_optimize_ranges(GSList *ranges);
 gboolean cbs_topic_in_range(unsigned int topic, GSList *ranges);
+
+#endif /* #ifndef __smsutil_h__ */
-- =

1.6.6.1


--===============8197697726313674882==--

