Content-Type: multipart/mixed; boundary="===============6550398714427111415=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 5/5] Remove hfpmodem's header guard
Date: Fri, 04 Jun 2010 23:40:04 -0300
Message-ID: <1275705604-8052-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275705604-8052-4-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6550398714427111415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/hfpmodem.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index c95ea3f..bf5d563 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -18,8 +18,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
  */
-#ifndef __BLUETOOTH_H__
-#define __BLUETOOTH_H__
 =

 #include <drivers/atmodem/atutil.h>
 #include <ofono/dbus.h>
@@ -82,5 +80,3 @@ extern void hfp_call_volume_exit();
 =

 extern void hfp_voicecall_init();
 extern void hfp_voicecall_exit();
-
-#endif
-- =

1.7.1


--===============6550398714427111415==--

