Content-Type: multipart/mixed; boundary="===============5430378716858512338=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 05/16] mbpi: Improve mbpi_lookup() error reporting
Date: Wed, 05 Oct 2011 16:18:28 +0300
Message-ID: <1317820719-23609-6-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5430378716858512338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 8f3a4b4..0f7cd50 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -378,7 +378,8 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
 	if (fd < 0) {
 		g_set_error(error, G_FILE_ERROR,
 				g_file_error_from_errno(errno),
-				"open failed: %s", g_strerror(errno));
+				"open(%s) failed: %s", MBPI_DATABASE,
+				g_strerror(errno));
 		return NULL;
 	}
 =

@@ -386,7 +387,8 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
 		close(fd);
 		g_set_error(error, G_FILE_ERROR,
 				g_file_error_from_errno(errno),
-				"fstat failed: %s", g_strerror(errno));
+				"fstat(%s) failed: %s", MBPI_DATABASE,
+				g_strerror(errno));
 		return NULL;
 	}
 =

@@ -395,7 +397,8 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
 		close(fd);
 		g_set_error(error, G_FILE_ERROR,
 				g_file_error_from_errno(errno),
-				"mmap failed: %s", g_strerror(errno));
+				"mmap(%s) failed: %s", MBPI_DATABASE,
+				g_strerror(errno));
 		return NULL;
 	}
 =

-- =

1.7.4.1


--===============5430378716858512338==--

