Content-Type: multipart/mixed; boundary="===============7889245975781159834=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Write state of SMS assembly to disk and restore on startup.
Date: Sat, 22 Aug 2009 04:40:43 +0200
Message-ID: <1250908843-10576-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7889245975781159834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This way we can continue receiving segmented messages over a reset or
crash.
---
 src/common.c     |   29 +++++++
 src/common.h     |   10 +++
 src/sim.c        |   34 --------
 src/sms.c        |   14 +++-
 src/smsutil.c    |  237 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/smsutil.h    |    3 +-
 unit/Makefile.am |    6 +-
 unit/test-sms.c  |    4 +-
 8 files changed, 293 insertions(+), 44 deletions(-)

diff --git a/src/common.c b/src/common.c
index 14bf7f9..e1d560e 100644
--- a/src/common.c
+++ b/src/common.c
@@ -26,6 +26,7 @@
 #define _GNU_SOURCE
 #include <string.h>
 #include <ctype.h>
+#include <errno.h>
 =

 #include <glib.h>
 =

@@ -593,3 +594,31 @@ gboolean is_valid_pin(const char *pin)
 =

 	return TRUE;
 }
+
+int create_dirs(const char *filename, const mode_t mode)
+{
+	struct stat st;
+	char *dir;
+	const char *prev, *next;
+	int err;
+
+	err =3D stat(filename, &st);
+	if (!err && S_ISREG(st.st_mode))
+		return 0;
+
+	dir =3D g_malloc(strlen(filename) + 1);
+	strcpy(dir, "/");
+
+	for (prev =3D filename; (next =3D strchr(prev + 1, '/')); prev =3D next)
+		if (next > prev + 1) {
+			strncat(dir, prev + 1, next - prev);
+
+			if (mkdir(dir, mode) && errno !=3D EEXIST) {
+				g_free(dir);
+				return -1;
+			}
+		}
+
+	g_free(dir);
+	return 0;
+}
diff --git a/src/common.h b/src/common.h
index 3805e21..18fb0c5 100644
--- a/src/common.h
+++ b/src/common.h
@@ -135,3 +135,13 @@ const char *ss_control_type_to_string(enum ss_control_=
type type);
 const char *bearer_class_to_string(enum bearer_class cls);
 =

 gboolean is_valid_pin(const char *pin);
+
+#ifdef TEMP_FAILURE_RETRY
+#define TFR TEMP_FAILURE_RETRY
+#else
+#define TFR
+#endif
+
+#include <fcntl.h>
+
+int create_dirs(const char *filename, const mode_t mode);
diff --git a/src/sim.c b/src/sim.c
index d4387c9..cd608f7 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -44,12 +44,6 @@
 #include "sim.h"
 #include "simutil.h"
 =

-#ifdef TEMP_FAILURE_RETRY
-#define TFR TEMP_FAILURE_RETRY
-#else
-#define TFR
-#endif
-
 #define SIM_MANAGER_INTERFACE "org.ofono.SimManager"
 =

 #define SIM_CACHE_MODE 0600
@@ -515,34 +509,6 @@ static void sim_retrieve_imsi(struct ofono_modem *mode=
m)
 	sim->ops->read_imsi(modem, sim_imsi_cb, modem);
 }
 =

-static int create_dirs(const char *filename, const mode_t mode)
-{
-	struct stat st;
-	char *dir;
-	const char *prev, *next;
-	int err;
-
-	err =3D stat(filename, &st);
-	if (!err && S_ISREG(st.st_mode))
-		return 0;
-
-	dir =3D g_malloc(strlen(filename) + 1);
-	strcpy(dir, "/");
-
-	for (prev =3D filename; (next =3D strchr(prev + 1, '/')); prev =3D next)
-		if (next > prev + 1) {
-			strncat(dir, prev + 1, next - prev);
-
-			if (mkdir(dir, mode) && errno !=3D EEXIST) {
-				g_free(dir);
-				return -1;
-			}
-		}
-
-	g_free(dir);
-	return 0;
-}
-
 static void sim_op_error(struct ofono_modem *modem)
 {
 	struct sim_manager_data *sim =3D modem->sim_manager;
diff --git a/src/sms.c b/src/sms.c
index c7d83fa..0781f86 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -72,7 +72,6 @@ static struct sms_manager_data *sms_manager_create()
 	sms->sca.type =3D 129;
 	sms->ref =3D 1;
 =

-	sms->assembly =3D sms_assembly_new();
 	sms->txq =3D g_queue_new();
 =

 	return sms;
@@ -792,6 +791,14 @@ void ofono_sms_status_notify(struct ofono_modem *modem=
, unsigned char *pdu,
 	ofono_error("SMS Status-Report not yet handled");
 }
 =

+static void sms_got_imsi(struct ofono_modem *modem)
+{
+	const char *imsi =3D ofono_sim_get_imsi(modem);
+	struct sms_manager_data *sms =3D modem->sms_manager;
+
+	sms->assembly =3D sms_assembly_new(imsi);
+}
+
 int ofono_sms_manager_register(struct ofono_modem *modem,
 					struct ofono_sms_ops *ops)
 {
@@ -830,6 +837,11 @@ int ofono_sms_manager_register(struct ofono_modem *mod=
em,
 =

 	ofono_modem_add_interface(modem, SMS_MANAGER_INTERFACE);
 =

+	if (ofono_sim_get_ready(modem))
+		sms_got_imsi(modem);
+	else
+		ofono_sim_ready_notify_register(modem, sms_got_imsi);
+
 	return 0;
 }
 =

diff --git a/src/smsutil.c b/src/smsutil.c
index fcff9aa..2480d71 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -23,11 +23,20 @@
 #include <config.h>
 #endif
 =

+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <glib.h>
-
+#include <dirent.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include "driver.h"
+#include "common.h"
 #include "util.h"
 #include "smsutil.h"
 =

@@ -2106,9 +2115,211 @@ char *sms_decode_text(GSList *sms_list)
 	return utf8;
 }
 =

-struct sms_assembly *sms_assembly_new()
+static int sms_serialize(unsigned char *buf, const struct sms *sms)
+{
+	int len, tpdu_len;
+
+	sms_encode(sms, &len, &tpdu_len, buf + 1);
+	buf[0] =3D tpdu_len;
+
+	return len;
+}
+
+static gboolean sms_deserialize(const unsigned char *buf,
+		struct sms *sms, int len)
+{
+	if (len < 1)
+		return FALSE;
+
+	return sms_decode(buf + 1, len - 1, FALSE, buf[0], sms);
+}
+
+static GSList *sms_assembly_add_fragment_backup(struct sms_assembly *assem=
bly,
+					const struct sms *sms, time_t ts,
+					const struct sms_address *addr,
+					guint16 ref, guint8 max, guint8 seq,
+					gboolean backup);
+
+#define SMS_BACKUP_MODE 0600
+#define SMS_BACKUP_PATH STORAGEDIR "/%s/sms"
+#define SMS_BACKUP_PATH_DIR SMS_BACKUP_PATH "/%s-%i-%i"
+#define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
+
+#define SMS_ADDR_FMT "%21[0-9+*#]"
+
+static void sms_assembly_load(struct sms_assembly *assembly,
+				const struct dirent *dir)
+{
+	struct sms_address addr;
+	char straddr[sizeof(addr.address) + 1];
+	guint16 ref;
+	guint8 max;
+	guint8 seq;
+	char *path;
+	int len;
+	struct stat segment_stat;
+	struct dirent **segments;
+	char *endp;
+	int fd;
+	int r;
+	unsigned char buf[177];
+	struct sms segment;
+
+	if (dir->d_type !=3D DT_DIR)
+		return;
+
+	if (sscanf(dir->d_name, SMS_ADDR_FMT "-%hi-%hhi",
+				straddr, &ref, &max) < 3)
+		return;
+	sms_address_from_string(&addr, straddr);
+
+	path =3D g_strdup_printf(SMS_BACKUP_PATH "/%s",
+			assembly->imsi, dir->d_name);
+	len =3D scandir(path, &segments, NULL, versionsort);
+	g_free(path);
+
+	if (len < 0)
+		return;
+
+	for (; len--; free(segments[len])) {
+		if (segments[len]->d_type !=3D DT_REG)
+			continue;
+
+		seq =3D strtol(segments[len]->d_name, &endp, 10);
+		if (*endp !=3D '\0')
+			continue;
+
+		path =3D g_strdup_printf(SMS_BACKUP_PATH "/%s/%s",
+				assembly->imsi,
+				dir->d_name, segments[len]->d_name);
+		fd =3D TFR(open(path, O_RDONLY));
+		g_free(path);
+
+		if (fd =3D=3D -1)
+			continue;
+
+		if (fstat(fd, &segment_stat) !=3D 0) {
+			TFR(close(fd));
+			continue;
+		}
+
+		r =3D TFR(read(fd, buf, sizeof(buf)));
+
+		if (r > 0 && sms_deserialize(buf, &segment, r)) {
+			if (sms_assembly_add_fragment_backup(assembly,
+						&segment,
+						segment_stat.st_mtime,
+						&addr, ref, max, seq, FALSE)) {
+				/* This can't happen */
+			}
+		}
+
+		TFR(close(fd));
+	}
+
+	free(segments);
+}
+
+static gboolean sms_assembly_store(struct sms_assembly *assembly,
+				struct sms_assembly_node *node,
+				const struct sms *sms, guint8 seq)
+{
+	unsigned char buf[177];
+	char *path;
+	int fd;
+	int len;
+
+	if (!assembly->imsi)
+		return;
+
+	len =3D sms_serialize(buf, sms);
+
+	path =3D g_strdup_printf(SMS_BACKUP_PATH_FILE, assembly->imsi,
+				sms_address_to_string(&node->addr),
+				node->ref, node->max_fragments, seq);
+
+	if (create_dirs(path, SMS_BACKUP_MODE | S_IXUSR)) {
+		g_free(path);
+		return FALSE;
+	}
+
+	fd =3D TFR(open(path, O_WRONLY | O_CREAT, SMS_BACKUP_MODE));
+	if (fd =3D=3D -1) {
+		g_free(path);
+		return FALSE;
+	}
+
+	if (TFR(write(fd, buf, len)) < len) {
+		TFR(close(fd));
+		unlink(path);
+		g_free(path);
+		return FALSE;
+	}
+
+	g_free(path);
+	TFR(close(fd));
+
+	return TRUE;
+}
+
+static void sms_assembly_backup_free(struct sms_assembly *assembly,
+					struct sms_assembly_node *node)
 {
-	return g_new0(struct sms_assembly, 1);
+	char *path;
+	int seq;
+
+	if (!assembly->imsi)
+		return;
+
+	for (seq =3D 0; seq < node->max_fragments; seq++) {
+		int offset =3D seq / 32;
+		int bit =3D 1 << (seq % 32);
+
+		if (node->bitmap[offset] & bit) {
+			path =3D g_strdup_printf(SMS_BACKUP_PATH_FILE,
+					assembly->imsi,
+					sms_address_to_string(&node->addr),
+					node->ref, node->max_fragments, seq);
+			unlink(path);
+			g_free(path);
+		}
+	}
+
+	path =3D g_strdup_printf(SMS_BACKUP_PATH_DIR, assembly->imsi,
+				sms_address_to_string(&node->addr),
+				node->ref, node->max_fragments);
+	unlink(path);
+	g_free(path);
+}
+
+struct sms_assembly *sms_assembly_new(const char *imsi)
+{
+	struct sms_assembly *ret =3D g_new0(struct sms_assembly, 1);
+	char *path;
+	struct dirent **entries;
+	int len;
+
+	if (imsi) {
+		ret->imsi =3D imsi;
+
+		/* Restore state from backup */
+
+		path =3D g_strdup_printf(SMS_BACKUP_PATH, imsi);
+		len =3D scandir(path, &entries, NULL, alphasort);
+		g_free(path);
+
+		if (len < 0)
+			return ret;
+
+		while (len--) {
+			sms_assembly_load(ret, entries[len]);
+			free(entries[len]);
+		}
+
+		free(entries);
+	}
+
+	return ret;
 }
 =

 void sms_assembly_free(struct sms_assembly *assembly)
@@ -2132,6 +2343,16 @@ GSList *sms_assembly_add_fragment(struct sms_assembl=
y *assembly,
 					const struct sms_address *addr,
 					guint16 ref, guint8 max, guint8 seq)
 {
+	sms_assembly_add_fragment_backup(assembly, sms,
+						ts, addr, ref, max, seq, TRUE);
+}
+
+static GSList *sms_assembly_add_fragment_backup(struct sms_assembly *assem=
bly,
+					const struct sms *sms, time_t ts,
+					const struct sms_address *addr,
+					guint16 ref, guint8 max, guint8 seq,
+					gboolean backup)
+{
 	int offset =3D seq / 32;
 	int bit =3D 1 << (seq % 32);
 	GSList *l;
@@ -2205,11 +2426,17 @@ out:
 	node->bitmap[offset] |=3D bit;
 	node->num_fragments +=3D 1;
 =

-	if (node->num_fragments < node->max_fragments)
+	if (node->num_fragments < node->max_fragments) {
+		if (backup)
+			sms_assembly_store(assembly, node, sms, seq);
+
 		return NULL;
+	}
 =

 	completed =3D node->fragment_list;
 =

+	sms_assembly_backup_free(assembly, node);
+
 	if (prev)
 		prev->next =3D l->next;
 	else
@@ -2243,6 +2470,8 @@ void sms_assembly_expire(struct sms_assembly *assembl=
y, time_t before)
 			continue;
 		}
 =

+		sms_assembly_backup_free(assembly, node);
+
 		g_slist_foreach(node->fragment_list, (GFunc)g_free, 0);
 		g_slist_free(node->fragment_list);
 		g_free(node);
diff --git a/src/smsutil.h b/src/smsutil.h
index 95d0c78..f6541b6 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -360,6 +360,7 @@ struct sms_assembly_node {
 };
 =

 struct sms_assembly {
+	const char *imsi;
 	GSList *assembly_list;
 };
 =

@@ -454,7 +455,7 @@ gboolean sms_extract_concatenation(const struct sms *sm=
s, guint16 *ref_num,
 unsigned char *sms_decode_datagram(GSList *sms_list, long *out_len);
 char *sms_decode_text(GSList *sms_list);
 =

-struct sms_assembly *sms_assembly_new();
+struct sms_assembly *sms_assembly_new(const char *imsi);
 void sms_assembly_free(struct sms_assembly *assembly);
 GSList *sms_assembly_add_fragment(struct sms_assembly *assembly,
 					const struct sms *sms, time_t ts,
diff --git a/unit/Makefile.am b/unit/Makefile.am
index 8a27267..74d0f40 100644
--- a/unit/Makefile.am
+++ b/unit/Makefile.am
@@ -6,11 +6,13 @@ test_common_SOURCES =3D test-common.c $(top_srcdir)/src/c=
ommon.c
 test_util_SOURCES =3D test-util.c $(top_srcdir)/src/util.c
 =

 test_sms_SOURCES =3D test-sms.c $(top_srcdir)/src/util.c \
-					$(top_srcdir)/src/smsutil.c
+					$(top_srcdir)/src/smsutil.c \
+					$(top_srcdir)/src/common.c
 =

 test_simutil_SOURCES =3D test-simutil.c $(top_srcdir)/src/util.c \
 					$(top_srcdir)/src/simutil.c \
-					$(top_srcdir)/src/smsutil.c
+					$(top_srcdir)/src/smsutil.c \
+					$(top_srcdir)/src/common.c
 =

 LDADD =3D @GLIB_LIBS@ @GTHREAD_LIBS@
 =

diff --git a/unit/test-sms.c b/unit/test-sms.c
index 52d6859..a94cd4b 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -619,7 +619,7 @@ static void test_assembly()
 	unsigned char pdu[164];
 	long pdu_len;
 	struct sms sms;
-	struct sms_assembly *assembly =3D sms_assembly_new();
+	struct sms_assembly *assembly =3D sms_assembly_new(NULL);
 	guint16 ref;
 	guint8 max;
 	guint8 seq;
@@ -776,7 +776,7 @@ static void test_prepare_concat()
 	struct sms *sms;
 	struct sms decoded;
 	int pdu_len, tpdu_len;
-	struct sms_assembly *assembly =3D sms_assembly_new();
+	struct sms_assembly *assembly =3D sms_assembly_new(NULL);
 	guint16 ref;
 	guint8 max;
 	guint8 seq;
-- =

1.6.1


--===============7889245975781159834==--

