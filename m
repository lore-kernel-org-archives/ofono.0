Content-Type: multipart/mixed; boundary="===============9199238978253011908=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 04/20] SMS: introduce message ID API
Date: Mon, 26 Jul 2010 19:10:48 -0500
Message-ID: <4C4E2408.4000100@gmail.com>
In-Reply-To: <23dfa720ca16b64a098ec2ba1068be10c263cb87.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9199238978253011908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 07/23/2010 03:59 PM, Inaky Perez-Gonzalez wrote:
> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> This adds a simple API to use for generating unique IDs for SMS
> messages.
> =

> Note this adds missing #includes to src/smsutil.h; header files should
> included from any other .c or .h file.
> ---
>  Makefile.am            |    5 +-
>  src/smsutil.c          |  191 +++++++++++++++++++++++++++++++++++++++++++
>  src/smsutil.h          |   87 ++++++++++++++++++++
>  unit/test-sms-msg-id.c |  212 ++++++++++++++++++++++++++++++++++++++++++=
++++++

Any time you change files in multiple directories, send multiple patches
for each directory.  E.g. src/smsutil.[ch] in patch 1, Makefile.am and
unit/test-sms-msg-id.c in patch 2.

>  4 files changed, 494 insertions(+), 1 deletions(-)
>  create mode 100644 unit/test-sms-msg-id.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index e256841..5a371c2 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -361,7 +361,7 @@ unit_objects =3D
>  noinst_PROGRAMS =3D unit/test-common unit/test-util unit/test-idmap \
>  					unit/test-sms unit/test-simutil \
>  					unit/test-mux unit/test-caif \
> -					unit/test-stkutil
> +					unit/test-stkutil unit/test-sms-msg-id
>  =

>  unit_test_common_SOURCES =3D unit/test-common.c src/common.c
>  unit_test_common_LDADD =3D @GLIB_LIBS@
> @@ -400,6 +400,9 @@ unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat=
_sources) \
>  unit_test_caif_LDADD =3D @GLIB_LIBS@
>  unit_objects +=3D $(unit_test_caif_OBJECTS)
>  =

> +unit_test_sms_msg_id_SOURCES =3D unit/test-sms-msg-id.c src/util.c src/s=
msutil.c src/storage.c
> +unit_test_sms_msg_id_LDADD =3D @GLIB_LIBS@
> +
>  noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qc=
dm
>  =

>  gatchat_gsmdial_SOURCES =3D gatchat/gsmdial.c $(gatchat_sources)
> diff --git a/src/smsutil.c b/src/smsutil.c
> index 6c2087a..f93ea5b 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -3982,3 +3982,194 @@ char *ussd_decode(int dcs, int len, const unsigne=
d char *data)
>  =

>  	return utf8;
>  }
> +
> +static
> +void sms_log_critical(const gchar *format, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, format);
> +	g_logv("SMS-MSG-ID", G_LOG_LEVEL_CRITICAL | G_LOG_FLAG_FATAL,
> +	       format, args);
> +	va_end(args);
> +}
> +

Please refrain from doing this inside utility code.  There should be no
printf / logs in smsutil.c

> +const GChecksumType SMS_MSG_ID_CHECKSUM =3D G_CHECKSUM_SHA256;
> +
> +
> +/*
> + * Internal function (also used for aiding in unit testing, hence not st=
atic)
> + */
> +gsize __sms_msg_id_hash_length(void)
> +{
> +	return g_checksum_type_get_length(SMS_MSG_ID_CHECKSUM);
> +}
> +
> +

What is up with the double empty lines?

> +/**
> + * Initialize and reset a UUID's state
> + *
> + * \param msg_id Descriptor
> + */
> +void sms_msg_id_init(struct sms_msg_id *msg_id)
> +{
> +	memset(msg_id->id, 0, sizeof(msg_id->id));
> +	memset(&msg_id->checksum, 0, sizeof(msg_id->checksum));
> +}
> +
> +
> +/**
> + * Create a random UUID
> + *
> + * \param msg_id Descriptor
> + *
> + * \internal
> + *
> + * Crams the msg_id ID buffer with random 32-bit numbers; because we
> + * use a byte based buffer, we play the cast to guint32 trick (as that
> + * is what g_random_int() returns).
> + */
> +void sms_msg_id_random(struct sms_msg_id *msg_id)
> +{
> +	guint32 *b;
> +	unsigned cnt, top;
> +
> +	/* Fail building if the size of the ID block is not a full
> +	 * multiple of a guint32's size. */
> +	BUILD_BUG_ON(sizeof(msg_id->id) % sizeof(b[0]) !=3D 0);
> +
> +	top =3D sizeof(msg_id->id) / sizeof(b[0]);
> +	b =3D (void *) msg_id->id;
> +	for (cnt =3D 0; cnt < top; cnt++)
> +		b[cnt] =3D g_random_int();
> +	/* mark hash is initialized */
> +	msg_id->checksum =3D (void *) ~0;
> +}

I really question the utility of this function.  We should always be
able to generate a message id based on the contents.

> +
> +
> +/**
> + * Feed data to the hash for generation of a UUID
> + *
> + * Provides a data buffer to be added to the hash from which a UUID
> + * will be generated. When done providing buffers, call with a %NULL
> + * buffer to get the hash finalized and the UUID.
> + *
> + * \param msg_id Descriptor
> + * \param buf Pointer to data buffer. Call with %NULL to finalize the
> + *     hash and generate the UUID. Note that after calling with %NULL
> + *     you cannot call again with another buffer to generate another
> + *     UUID without calling sms_msg_id_init() first.
> + * \param buf_size size of the @buf buffer.
> + *
> + * NOTE:
> + *  - Will abort on OOM with an error message
> + *  - Will abort if called with %NULL as an argument to \param buf
> + *    without any non-NULL buffers were fed to in previous calls.
> + *  - In case of going over an error path before closing the UUID with
> + *    sms_msg_id_hash(%NULL), the hash has to be closed in order to
> + *    avoid memory leaks -- thus call sms_msg_id_hash(%NULL) in the
> + *    error path.
> + */
> +void sms_msg_id_hash(struct sms_msg_id *msg_id,
> +		     const void *buf, size_t buf_size)
> +{
> +	gsize digest_size =3D __sms_msg_id_hash_length();
> +	unsigned char digest[digest_size];
> +
> +	if (msg_id->checksum =3D=3D (void *) ~0) {
> +		sms_log_critical("%s:%d: SW BUG: %s(!NULL) called "
> +				 "on a closed hash\n",
> +				 __FILE__, __LINE__, __func__);
> +		return;
> +	}
> +	if (buf =3D=3D NULL) {
> +		if (msg_id->checksum =3D=3D NULL) {
> +			sms_log_critical("%s:%d: BUG: %s(NULL) called "
> +					 "without feeding data first\n",
> +					 __FILE__, __LINE__, __func__);
> +			return;
> +		}
> +		g_checksum_get_digest(msg_id->checksum,
> +				      digest, &digest_size);
> +		memcpy(msg_id->id, digest,
> +		       MIN(digest_size, sizeof(msg_id->id)));
> +		if (digest_size < sizeof(msg_id->id))
> +			memset(msg_id->id + digest_size, 0,
> +			       sizeof(msg_id->id) - digest_size);
> +		g_checksum_free(msg_id->checksum);
> +		/* mark hash is initialized */
> +		msg_id->checksum =3D (void *) ~0;
> +	} else {
> +		/* Word has it g_checksum_new(), which uses
> +		 * g_slice_alloc() will abort() on allocation
> +		 * failure. However, is not really documented
> +		 * anywhere, so the extra check -- and we just abort
> +		 * on OOM. */
> +		if (msg_id->checksum =3D=3D NULL) {
> +			msg_id->checksum =3D g_checksum_new(SMS_MSG_ID_CHECKSUM);
> +			if (msg_id->checksum =3D=3D NULL)
> +				sms_log_critical("%s:%d: OOM: can't allocate "
> +						 "checksum",
> +						 __FILE__, __LINE__);
> +		}
> +		g_checksum_update(msg_id->checksum, buf, buf_size);
> +	}
> +}
> +
> +
> +/**
> + * Print a UUID to a string buffer
> + *
> + * Given a closed UUID, print it as a hexadecimal string to a provided
> + * buffer display (lowest nibble right).
> + *
> + * \param msg_id Descriptor
> + * \param strbuf String where to format the UUID
> + * \param strbuf_size Size of the string buffer.
> + *
> + * NOTE: @msg_id has to be closed, ie: sms_msg_id_random() or
> + *      sms_msg_id_hash(NULL) were called on them.
> + */
> +void sms_msg_id_printf(const struct sms_msg_id *msg_id,
> +		       char *strbuf, size_t strbuf_size)
> +{
> +	int cnt;
> +	size_t written =3D 0;
> +
> +	if (msg_id->checksum !=3D (void *) ~0) {
> +		sms_log_critical("%s:%d: BUG: %s() called on an open hash\n",
> +				 __FILE__, __LINE__, __func__);
> +		return;
> +	}
> +	for (cnt =3D 0; cnt < SMS_MSG_ID_HASH_SIZE; cnt++)
> +		written +=3D snprintf(strbuf + written, strbuf_size - written,
> +				    "%02x", msg_id->id[cnt] & 0xff);
> +}
> +
> +
> +/**
> + * Print a UUID to a string buffer
> + *
> + * Given a closed UUID, print it as a hexadecimal string to a provided
> + * buffer display (lowest nibble right).
> + *
> + * \param msg_id Descriptor
> + * \param strbuf String where to format the UUID
> + * \param strbuf_size Size of the string buffer.
> + *
> + * NOTE: @msg_id has to be closed, ie: sms_msg_id_random() or
> + *      sms_msg_id_hash(NULL) were called on them.
> + */
> +void sms_msg_id_memcpy(void *buf, size_t buf_size,
> +		       const struct sms_msg_id *msg_id)
> +{
> +	size_t copy_size =3D MIN(buf_size, sizeof(msg_id->id));
> +	if (msg_id->checksum !=3D (void *) ~0) {
> +		sms_log_critical("%s:%d: BUG: %s() called on an open hash\n",
> +				 __FILE__, __LINE__, __func__);
> +		return;
> +	}
> +	memmove(buf, msg_id->id, MIN(buf_size, sizeof(msg_id->id)));
> +	if (copy_size < buf_size)
> +		memset(buf + copy_size, 0, buf_size - copy_size);
> +}

Exposing all this API as public leads to lots of totally unnecessary
code.  The philosophy should be the opposite, e.g. exposing as little as
possible to the end user.

The API needs to be shrunk down to maybe 2-3 simple functions and most
of the extra pedantic checks removed.

> diff --git a/src/smsutil.h b/src/smsutil.h
> index 66ef6f8..fbe3c72 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -19,6 +19,12 @@
>   *
>   */
>  =

> +#include <time.h>
> +#include <glib/gtypes.h>
> +#include <glib/gslist.h>
> +#include <glib/ghash.h>
> +#include <glib/gchecksum.h>
> +
>  #define CBS_MAX_GSM_CHARS 93
>  =

>  enum sms_type {
> @@ -539,3 +545,84 @@ GSList *cbs_optimize_ranges(GSList *ranges);
>  gboolean cbs_topic_in_range(unsigned int topic, GSList *ranges);
>  =

>  char *ussd_decode(int dcs, int len, const unsigned char *data);
> +
> +enum {
> +	/* Note this has to be a multiple of sizeof(guint32);
> +	 * Compilation will assert-fail if this is not met. */
> +	SMS_MSG_ID_HASH_SIZE =3D 16,
> +};
> +
> +/**
> + * Unique identifiers
> + *
> + * Generate unique identifiers to map data. Can be initialized with a
> + * random identifier or by creating a hash based on data contents.
> + *
> + * \NOTE Never access the struct's contents directly; use the
> + *     sms_msg_id*() API
> + *
> + * Usage
> + *
> + * Declare and initialize:
> + *
> + * \code
> + *   struct sms_msg_id msg_id;
> + *
> + *   sms_msg_id_init(&msg_id);	// initialize to known state
> + * \endcode
> + *
> + * Initialize with a random ID
> + *
> + * \code
> + *   sms_msg_id_random(&msg_id);	// Create a random unique ID
> + * \endcode
> + *
> + * or initialize by hashing data buffers:
> + *
> + * \code
> + *   sms_msg_id_hash(&msg_id, buf1, buf1_size);
> + *   sms_msg_id_hash(&msg_id, buf2, buf2_size);
> + *   sms_msg_id_hash(&msg_id, buf3, buf3_size);
> + *   ...
> + *   sms_msg_id_hash(&msg_id, NULL, 0);
> + * \endcode
> + *
> + * Once the hash has been initialized, it can be accessed. Never
> + * access it before initializing the hash (it will trigger a software
> + * error and abort).
> + *
> + * Formating for printing:
> + *
> + * \code
> + *   DECLARE_SMS_MSG_ID_STRBUF(buf);
> + *   ...
> + *   sms_msg_id_printf(&msg_id, buf, sizeof(buf));
> + * \endcode
> + *
> + * Copying the hash data to a buffer
> + *
> + * \code
> + *   sms_msg_id_memcpy(buf, buf_size, &msg_id);
> + * \endcode
> + *
> + * For generating another ID (with sms_msg_id_random() or
> + * sms_msg_id_hash()), sms_msg_id_init() has to be called.
> + */
> +
> +struct sms_msg_id {
> +	guint8 id[SMS_MSG_ID_HASH_SIZE];
> +	GChecksum *checksum;
> +};
> +
> +#define DECLARE_SMS_MSG_ID_STRBUF(strbuf)	\
> +	char strbuf[SMS_MSG_ID_HASH_SIZE * 2 + 1]
> +
> +void sms_msg_id_init(struct sms_msg_id *);
> +void sms_msg_id_random(struct sms_msg_id *);
> +void sms_msg_id_hash(struct sms_msg_id *, const void *, size_t);
> +
> +void sms_msg_id_printf(const struct sms_msg_id *, char *, size_t);
> +void sms_msg_id_memcpy(void *, size_t, const struct sms_msg_id *);
> +
> +/* for unit testing only */
> +gsize __sms_msg_id_hash_length(void);

I think this is just way too complicated ...

I suggest something like:

struct sms_uuid {
	uint8_t id[hash_size];
};

// oFono is not multithreaded, so static return is fine
const char *sms_uuid_to_string(const struct ofono_uuid *uuid);
int sms_uuid_from_sms_list(GSList *list,
				struct ofono_uuid *out_uuid);

Regards,
-Denis

--===============9199238978253011908==--

