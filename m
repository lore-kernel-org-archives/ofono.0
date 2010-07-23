Content-Type: multipart/mixed; boundary="===============3415939194789558439=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 04/20] SMS: introduce message ID API
Date: Fri, 23 Jul 2010 13:59:52 -0700
Message-ID: <23dfa720ca16b64a098ec2ba1068be10c263cb87.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3415939194789558439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This adds a simple API to use for generating unique IDs for SMS
messages.

Note this adds missing #includes to src/smsutil.h; header files should
included from any other .c or .h file.
---
 Makefile.am            |    5 +-
 src/smsutil.c          |  191 +++++++++++++++++++++++++++++++++++++++++++
 src/smsutil.h          |   87 ++++++++++++++++++++
 unit/test-sms-msg-id.c |  212 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 494 insertions(+), 1 deletions(-)
 create mode 100644 unit/test-sms-msg-id.c

diff --git a/Makefile.am b/Makefile.am
index e256841..5a371c2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -361,7 +361,7 @@ unit_objects =3D
 noinst_PROGRAMS =3D unit/test-common unit/test-util unit/test-idmap \
 					unit/test-sms unit/test-simutil \
 					unit/test-mux unit/test-caif \
-					unit/test-stkutil
+					unit/test-stkutil unit/test-sms-msg-id
 =

 unit_test_common_SOURCES =3D unit/test-common.c src/common.c
 unit_test_common_LDADD =3D @GLIB_LIBS@
@@ -400,6 +400,9 @@ unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_s=
ources) \
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

+unit_test_sms_msg_id_SOURCES =3D unit/test-sms-msg-id.c src/util.c src/sms=
util.c src/storage.c
+unit_test_sms_msg_id_LDADD =3D @GLIB_LIBS@
+
 noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
 =

 gatchat_gsmdial_SOURCES =3D gatchat/gsmdial.c $(gatchat_sources)
diff --git a/src/smsutil.c b/src/smsutil.c
index 6c2087a..f93ea5b 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3982,3 +3982,194 @@ char *ussd_decode(int dcs, int len, const unsigned =
char *data)
 =

 	return utf8;
 }
+
+static
+void sms_log_critical(const gchar *format, ...)
+{
+	va_list args;
+
+	va_start(args, format);
+	g_logv("SMS-MSG-ID", G_LOG_LEVEL_CRITICAL | G_LOG_FLAG_FATAL,
+	       format, args);
+	va_end(args);
+}
+
+const GChecksumType SMS_MSG_ID_CHECKSUM =3D G_CHECKSUM_SHA256;
+
+
+/*
+ * Internal function (also used for aiding in unit testing, hence not stat=
ic)
+ */
+gsize __sms_msg_id_hash_length(void)
+{
+	return g_checksum_type_get_length(SMS_MSG_ID_CHECKSUM);
+}
+
+
+/**
+ * Initialize and reset a UUID's state
+ *
+ * \param msg_id Descriptor
+ */
+void sms_msg_id_init(struct sms_msg_id *msg_id)
+{
+	memset(msg_id->id, 0, sizeof(msg_id->id));
+	memset(&msg_id->checksum, 0, sizeof(msg_id->checksum));
+}
+
+
+/**
+ * Create a random UUID
+ *
+ * \param msg_id Descriptor
+ *
+ * \internal
+ *
+ * Crams the msg_id ID buffer with random 32-bit numbers; because we
+ * use a byte based buffer, we play the cast to guint32 trick (as that
+ * is what g_random_int() returns).
+ */
+void sms_msg_id_random(struct sms_msg_id *msg_id)
+{
+	guint32 *b;
+	unsigned cnt, top;
+
+	/* Fail building if the size of the ID block is not a full
+	 * multiple of a guint32's size. */
+	BUILD_BUG_ON(sizeof(msg_id->id) % sizeof(b[0]) !=3D 0);
+
+	top =3D sizeof(msg_id->id) / sizeof(b[0]);
+	b =3D (void *) msg_id->id;
+	for (cnt =3D 0; cnt < top; cnt++)
+		b[cnt] =3D g_random_int();
+	/* mark hash is initialized */
+	msg_id->checksum =3D (void *) ~0;
+}
+
+
+/**
+ * Feed data to the hash for generation of a UUID
+ *
+ * Provides a data buffer to be added to the hash from which a UUID
+ * will be generated. When done providing buffers, call with a %NULL
+ * buffer to get the hash finalized and the UUID.
+ *
+ * \param msg_id Descriptor
+ * \param buf Pointer to data buffer. Call with %NULL to finalize the
+ *     hash and generate the UUID. Note that after calling with %NULL
+ *     you cannot call again with another buffer to generate another
+ *     UUID without calling sms_msg_id_init() first.
+ * \param buf_size size of the @buf buffer.
+ *
+ * NOTE:
+ *  - Will abort on OOM with an error message
+ *  - Will abort if called with %NULL as an argument to \param buf
+ *    without any non-NULL buffers were fed to in previous calls.
+ *  - In case of going over an error path before closing the UUID with
+ *    sms_msg_id_hash(%NULL), the hash has to be closed in order to
+ *    avoid memory leaks -- thus call sms_msg_id_hash(%NULL) in the
+ *    error path.
+ */
+void sms_msg_id_hash(struct sms_msg_id *msg_id,
+		     const void *buf, size_t buf_size)
+{
+	gsize digest_size =3D __sms_msg_id_hash_length();
+	unsigned char digest[digest_size];
+
+	if (msg_id->checksum =3D=3D (void *) ~0) {
+		sms_log_critical("%s:%d: SW BUG: %s(!NULL) called "
+				 "on a closed hash\n",
+				 __FILE__, __LINE__, __func__);
+		return;
+	}
+	if (buf =3D=3D NULL) {
+		if (msg_id->checksum =3D=3D NULL) {
+			sms_log_critical("%s:%d: BUG: %s(NULL) called "
+					 "without feeding data first\n",
+					 __FILE__, __LINE__, __func__);
+			return;
+		}
+		g_checksum_get_digest(msg_id->checksum,
+				      digest, &digest_size);
+		memcpy(msg_id->id, digest,
+		       MIN(digest_size, sizeof(msg_id->id)));
+		if (digest_size < sizeof(msg_id->id))
+			memset(msg_id->id + digest_size, 0,
+			       sizeof(msg_id->id) - digest_size);
+		g_checksum_free(msg_id->checksum);
+		/* mark hash is initialized */
+		msg_id->checksum =3D (void *) ~0;
+	} else {
+		/* Word has it g_checksum_new(), which uses
+		 * g_slice_alloc() will abort() on allocation
+		 * failure. However, is not really documented
+		 * anywhere, so the extra check -- and we just abort
+		 * on OOM. */
+		if (msg_id->checksum =3D=3D NULL) {
+			msg_id->checksum =3D g_checksum_new(SMS_MSG_ID_CHECKSUM);
+			if (msg_id->checksum =3D=3D NULL)
+				sms_log_critical("%s:%d: OOM: can't allocate "
+						 "checksum",
+						 __FILE__, __LINE__);
+		}
+		g_checksum_update(msg_id->checksum, buf, buf_size);
+	}
+}
+
+
+/**
+ * Print a UUID to a string buffer
+ *
+ * Given a closed UUID, print it as a hexadecimal string to a provided
+ * buffer display (lowest nibble right).
+ *
+ * \param msg_id Descriptor
+ * \param strbuf String where to format the UUID
+ * \param strbuf_size Size of the string buffer.
+ *
+ * NOTE: @msg_id has to be closed, ie: sms_msg_id_random() or
+ *      sms_msg_id_hash(NULL) were called on them.
+ */
+void sms_msg_id_printf(const struct sms_msg_id *msg_id,
+		       char *strbuf, size_t strbuf_size)
+{
+	int cnt;
+	size_t written =3D 0;
+
+	if (msg_id->checksum !=3D (void *) ~0) {
+		sms_log_critical("%s:%d: BUG: %s() called on an open hash\n",
+				 __FILE__, __LINE__, __func__);
+		return;
+	}
+	for (cnt =3D 0; cnt < SMS_MSG_ID_HASH_SIZE; cnt++)
+		written +=3D snprintf(strbuf + written, strbuf_size - written,
+				    "%02x", msg_id->id[cnt] & 0xff);
+}
+
+
+/**
+ * Print a UUID to a string buffer
+ *
+ * Given a closed UUID, print it as a hexadecimal string to a provided
+ * buffer display (lowest nibble right).
+ *
+ * \param msg_id Descriptor
+ * \param strbuf String where to format the UUID
+ * \param strbuf_size Size of the string buffer.
+ *
+ * NOTE: @msg_id has to be closed, ie: sms_msg_id_random() or
+ *      sms_msg_id_hash(NULL) were called on them.
+ */
+void sms_msg_id_memcpy(void *buf, size_t buf_size,
+		       const struct sms_msg_id *msg_id)
+{
+	size_t copy_size =3D MIN(buf_size, sizeof(msg_id->id));
+	if (msg_id->checksum !=3D (void *) ~0) {
+		sms_log_critical("%s:%d: BUG: %s() called on an open hash\n",
+				 __FILE__, __LINE__, __func__);
+		return;
+	}
+	memmove(buf, msg_id->id, MIN(buf_size, sizeof(msg_id->id)));
+	if (copy_size < buf_size)
+		memset(buf + copy_size, 0, buf_size - copy_size);
+}
diff --git a/src/smsutil.h b/src/smsutil.h
index 66ef6f8..fbe3c72 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -19,6 +19,12 @@
  *
  */
 =

+#include <time.h>
+#include <glib/gtypes.h>
+#include <glib/gslist.h>
+#include <glib/ghash.h>
+#include <glib/gchecksum.h>
+
 #define CBS_MAX_GSM_CHARS 93
 =

 enum sms_type {
@@ -539,3 +545,84 @@ GSList *cbs_optimize_ranges(GSList *ranges);
 gboolean cbs_topic_in_range(unsigned int topic, GSList *ranges);
 =

 char *ussd_decode(int dcs, int len, const unsigned char *data);
+
+enum {
+	/* Note this has to be a multiple of sizeof(guint32);
+	 * Compilation will assert-fail if this is not met. */
+	SMS_MSG_ID_HASH_SIZE =3D 16,
+};
+
+/**
+ * Unique identifiers
+ *
+ * Generate unique identifiers to map data. Can be initialized with a
+ * random identifier or by creating a hash based on data contents.
+ *
+ * \NOTE Never access the struct's contents directly; use the
+ *     sms_msg_id*() API
+ *
+ * Usage
+ *
+ * Declare and initialize:
+ *
+ * \code
+ *   struct sms_msg_id msg_id;
+ *
+ *   sms_msg_id_init(&msg_id);	// initialize to known state
+ * \endcode
+ *
+ * Initialize with a random ID
+ *
+ * \code
+ *   sms_msg_id_random(&msg_id);	// Create a random unique ID
+ * \endcode
+ *
+ * or initialize by hashing data buffers:
+ *
+ * \code
+ *   sms_msg_id_hash(&msg_id, buf1, buf1_size);
+ *   sms_msg_id_hash(&msg_id, buf2, buf2_size);
+ *   sms_msg_id_hash(&msg_id, buf3, buf3_size);
+ *   ...
+ *   sms_msg_id_hash(&msg_id, NULL, 0);
+ * \endcode
+ *
+ * Once the hash has been initialized, it can be accessed. Never
+ * access it before initializing the hash (it will trigger a software
+ * error and abort).
+ *
+ * Formating for printing:
+ *
+ * \code
+ *   DECLARE_SMS_MSG_ID_STRBUF(buf);
+ *   ...
+ *   sms_msg_id_printf(&msg_id, buf, sizeof(buf));
+ * \endcode
+ *
+ * Copying the hash data to a buffer
+ *
+ * \code
+ *   sms_msg_id_memcpy(buf, buf_size, &msg_id);
+ * \endcode
+ *
+ * For generating another ID (with sms_msg_id_random() or
+ * sms_msg_id_hash()), sms_msg_id_init() has to be called.
+ */
+
+struct sms_msg_id {
+	guint8 id[SMS_MSG_ID_HASH_SIZE];
+	GChecksum *checksum;
+};
+
+#define DECLARE_SMS_MSG_ID_STRBUF(strbuf)	\
+	char strbuf[SMS_MSG_ID_HASH_SIZE * 2 + 1]
+
+void sms_msg_id_init(struct sms_msg_id *);
+void sms_msg_id_random(struct sms_msg_id *);
+void sms_msg_id_hash(struct sms_msg_id *, const void *, size_t);
+
+void sms_msg_id_printf(const struct sms_msg_id *, char *, size_t);
+void sms_msg_id_memcpy(void *, size_t, const struct sms_msg_id *);
+
+/* for unit testing only */
+gsize __sms_msg_id_hash_length(void);
diff --git a/unit/test-sms-msg-id.c b/unit/test-sms-msg-id.c
new file mode 100644
index 0000000..f9dd5e2
--- /dev/null
+++ b/unit/test-sms-msg-id.c
@@ -0,0 +1,212 @@
+/*
+ * Exercise flows and corner cases of the SMS-MSG-ID API
+ *
+ * This unit attempts to prove the common code flow and corner cases
+ * of the SMS-MSG-ID API, as described by it's functions usage
+ * documentation.
+ *
+ * Relies on the fact that the SMS-MSG-ID code will call
+ * sms_log_critical() for every condition that warrants an abort. This
+ * will call g_logv() with a G_LOG_FLAG_FATAL flag, which can be
+ * intercepted at glib level by setting a fatal log handler
+ * [test_fatal_log()] with g_test_log_set_fatal_handler() and decide
+ * based on the return value if the program should abort (TRUE) or not
+ * (FALSE). Instead we set a flag to indicate the 'condition' has been
+ * detected.
+ */
+
+#include <smsutil.h>
+#include <stdio.h>
+#include <string.h>
+#include <glib/gtestutils.h>
+
+int fatal_error;
+
+gboolean test_fatal_log(const gchar *log_domain,
+			GLogLevelFlags log_level,
+			const gchar *message,
+			gpointer user_data)
+{
+	fatal_error =3D 1;
+	return FALSE;	/* Avoid program abort */
+}
+
+int main(void)
+{
+	int fail =3D 0;
+	struct sms_msg_id msg_id1, msg_id2;
+	size_t hash_length =3D __sms_msg_id_hash_length();
+	size_t id_length =3D SMS_MSG_ID_HASH_SIZE;
+	size_t cnt;
+	DECLARE_SMS_MSG_ID_STRBUF(str_id1);
+	DECLARE_SMS_MSG_ID_STRBUF(str_id2);
+	char blob1[SMS_MSG_ID_HASH_SIZE],
+		blob2[SMS_MSG_ID_HASH_SIZE],
+		blob_big[4 * hash_length];
+
+	printf("I: '**CRITICAL**' and 'aborting...' messages "
+	       "should be ignored\n");
+
+	/* mask fatal errors so they don't crash, but just notes it
+	 * happened @fatal_error -- this is called by
+	 * sms_log_critical() -> g_logv() [as it uses the
+	 * G_LOG_FLAG_FATAL indicator. */
+	fatal_error =3D 0;
+	g_test_log_set_fatal_handler(test_fatal_log, NULL);
+
+	sms_msg_id_init(&msg_id1);
+	sms_msg_id_init(&msg_id2);
+
+	/* should trap: hash not initialized */
+	sms_msg_id_printf(&msg_id1, str_id1, sizeof(str_id1));
+	if (fatal_error =3D=3D 1) {
+		printf("I: %d: sms_msg_id_printf() doesn't work on "
+		       "unitialized hash. OK\n", __LINE__);
+		fatal_error =3D 0;
+	} else {
+		fprintf(stderr, "E: %d: sms_msg_id_printf() didn't reject an "
+		       "unitialized hash. FAILURE\n", __LINE__);
+		fail =3D 1;
+	}
+	sms_msg_id_memcpy(blob1, sizeof(blob1), &msg_id1);
+	if (fatal_error =3D=3D 1) {
+		printf("I: %d: sms_msg_id_memcpy() doesn't work on "
+		       "unitialized hash. OK\n", __LINE__);
+		fatal_error =3D 0;
+	} else {
+		fprintf(stderr, "E: %d: sms_msg_id_memcpy() didn't reject an "
+		       "unitialized hash. FAILURE.\n", __LINE__);
+		fail =3D 1;
+	}
+
+	/* Make a random initialization */
+	sms_msg_id_random(&msg_id1);
+	sms_msg_id_random(&msg_id2);
+
+	/* Printf */
+	sms_msg_id_printf(&msg_id1, str_id1, sizeof(str_id1));
+	sms_msg_id_printf(&msg_id2, str_id2, sizeof(str_id2));
+	/* should be different */
+	if (strcmp(str_id1, str_id2))
+		printf("I: %d: strings for 1 & 2 are different, OK\n",
+			__LINE__);
+	else {
+		fprintf(stderr, "E: %d: strings for 1 & 2 match. FAILURE.\n",
+			__LINE__);
+		fail =3D 1;
+	}
+	printf("I: %d: str1 %s, str2 %s\n", __LINE__, str_id1, str_id2);
+
+	/* Reinitialize to test hash -- we feed the strings as binary
+	 * data */
+	sms_msg_id_init(&msg_id1);
+	/* Test sms_msg_id_hash(NULL) fails if no data was fed */
+	sms_msg_id_hash(&msg_id1, NULL, 0);
+	if (fatal_error =3D=3D 1) {
+		printf("I: %d: sms_msg_id_hash() rejects a non-fed "
+		       "hash. OK\n", __LINE__);
+		fatal_error =3D 0;
+	} else {
+		fprintf(stderr, "E: %d: sms_msg_id_hash() didn't reject a "
+		       "non-fed hash. FAILURE.\n", __LINE__);
+		fail =3D 1;
+	}
+	sms_msg_id_hash(&msg_id1, str_id1, sizeof(str_id1));
+	sms_msg_id_hash(&msg_id1, str_id2, sizeof(str_id2));
+	sms_msg_id_hash(&msg_id1, NULL, 0);
+	/* Should fail if we try to add more */
+	sms_msg_id_hash(&msg_id1, str_id1, sizeof(str_id1));
+	if (fatal_error =3D=3D 1) {
+		printf("I: %d: sms_msg_id_hash() rejects a closed "
+		       "hash. OK\n", __LINE__);
+		fatal_error =3D 0;
+	} else {
+		fprintf(stderr, "E: %d: sms_msg_id_hash() didn't reject a "
+		       "closed hash. FAILURE.\n", __LINE__);
+		fail =3D 1;
+	}
+	/* ... or close */
+	sms_msg_id_hash(&msg_id1, NULL, 0);
+	if (fatal_error =3D=3D 1) {
+		printf("I: %d: sms_msg_id_hash() rejects closing a closed "
+		       "hash. OK\n", __LINE__);
+		fatal_error =3D 0;
+	} else {
+		fprintf(stderr, "E: %d: sms_msg_id_hash() didn't reject "
+			" closing a closed hash. FAILURE.\n", __LINE__);
+		fail =3D 1;
+	}
+
+	sms_msg_id_init(&msg_id2);
+	sms_msg_id_hash(&msg_id2, str_id1, sizeof(str_id1));
+	sms_msg_id_hash(&msg_id2, str_id2, sizeof(str_id2));
+	sms_msg_id_hash(&msg_id2, NULL, 0);
+
+	/* extract the blobs, they should match as we generated the
+	 * hashes from identical buckets */
+	sms_msg_id_memcpy(blob1, sizeof(blob1), &msg_id1);
+	sms_msg_id_memcpy(blob2, sizeof(blob2), &msg_id2);
+	if (memcmp(blob1, blob2, sizeof(blob1))) {
+		fprintf(stderr, "E: %d: hashes don't match on identical feed. "
+			"FAILURE.\n", __LINE__);
+		fail =3D 1;
+	} else
+		printf("I: %d: hashes match on identical feed. "
+			"OK.\n", __LINE__);
+	sms_msg_id_printf(&msg_id1, str_id1, sizeof(str_id1));
+	sms_msg_id_printf(&msg_id2, str_id2, sizeof(str_id2));
+	/* should be the same */
+	if (!strcmp(str_id1, str_id2))
+		printf("I: %d: strings for 1 & 2 match. OK\n",
+			__LINE__);
+	else {
+		fprintf(stderr, "E: %d: strings for 1 & 2 differ. FAILURE.\n",
+			__LINE__);
+		fail =3D 1;
+	}
+	printf("I: %d: str1 %s, str2 %s\n", __LINE__, str_id1, str_id2);
+
+	/* if the blob is bigger than the hash, the rest should be
+	 * filled with zeroes */
+	memset(blob_big, 0xff, sizeof(blob_big));
+	sms_msg_id_memcpy(blob_big, sizeof(blob_big), &msg_id1);
+	for (cnt =3D hash_length; cnt < sizeof(blob_big); cnt++)
+		if (blob_big[cnt] !=3D 0) {
+			fprintf(stderr, "E: %d: blob @ #%u not zero. "
+				"FAILURE.\n", __LINE__, cnt);
+			fail =3D 1;
+			break;
+		}
+	if (cnt >=3D sizeof(blob_big))
+		printf("I: %d: remainder blob is zero. OK\n", __LINE__);
+
+	/* if the blob is smaller than the hash, the remainder should
+	 * not be touched */
+	sms_msg_id_init(&msg_id1);
+	sms_msg_id_random(&msg_id1);
+
+	sms_msg_id_init(&msg_id2);
+	sms_msg_id_random(&msg_id2);
+
+	sms_msg_id_memcpy(blob1, sizeof(blob1), &msg_id1);
+	/* Note we cut by four here! */
+	memcpy(blob1, blob2, sizeof(blob1));
+	sms_msg_id_memcpy(blob2, id_length / 4, &msg_id2);
+
+	for (cnt =3D id_length / 4; cnt < id_length; cnt++)
+		if (blob1[cnt] !=3D blob2[cnt]) {
+			fprintf(stderr, "E: %d: blob1 @ #%u doesn't match "
+				"blob2. FAILURE.\n", __LINE__, cnt);
+			fail =3D 1;
+			break;
+		}
+	if (cnt >=3D id_length)
+		printf("I: %d: remainder blob is untouched. OK\n",
+		       __LINE__);
+
+	if (fail)
+		fprintf(stderr, "E: FAILURE.\n");
+	else
+		printf("I: OK\n");
+	return fail;
+}
-- =

1.6.6.1


--===============3415939194789558439==--

