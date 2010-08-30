Content-Type: multipart/mixed; boundary="===============2484527681600727388=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH v3 2/4] smsutil: storing/loading sms status report
 over reboot
Date: Mon, 30 Aug 2010 17:30:57 -0500
Message-ID: <4C7C3121.7000400@gmail.com>
In-Reply-To: <1282932596-24494-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2484527681600727388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 08/27/2010 01:09 PM, Petteri Tikander wrote:
> ---
>  src/smsutil.c |  176 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  src/smsutil.h |   10 +++-
>  2 files changed, 180 insertions(+), 6 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index c60b8ec..88c567c 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -33,6 +33,7 @@
>  #include <unistd.h>
>  =

>  #include <glib.h>
> +#include <errno.h>

Remove this if strtoul is no longer used.

>  =

>  #include "util.h"
>  #include "storage.h"
> @@ -45,6 +46,9 @@
>  #define SMS_BACKUP_PATH_DIR SMS_BACKUP_PATH "/%s-%i-%i"
>  #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
>  =

> +#define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
> +#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH "/%s-%i"
> +
>  #define SMS_ADDR_FMT "%24[0-9A-F]"
>  =

>  static GSList *sms_assembly_add_fragment_backup(struct sms_assembly *ass=
embly,
> @@ -2413,7 +2417,7 @@ static void sms_assembly_backup_free(struct sms_ass=
embly *assembly,
>  {
>  	char *path;
>  	int seq;
> -	char straddr[25];
> +	DECLARE_SMS_ADDR_STR(straddr);

Please send this chunk as a separate patch, it doesn't belong to status
report assembly.

>  =

>  	if (!assembly->imsi)
>  		return;
> @@ -2529,7 +2533,8 @@ static GSList *sms_assembly_add_fragment_backup(str=
uct sms_assembly *assembly,
>  		if (ref !=3D node->ref)
>  			continue;
>  =

> -		/* Message Reference and address the same, but max is not
> +		/*
> +		 * Message Reference and address the same, but max is not
>  		 * ignore the SMS completely
>  		 */

Again, please send this as a separate cleanup patch.

>  		if (max !=3D node->max_fragments)
> @@ -2642,20 +2647,163 @@ void sms_assembly_expire(struct sms_assembly *as=
sembly, time_t before)
>  	}
>  }
>  =

> +static void sr_assembly_load_backup(GHashTable *assembly_table,
> +					const char *imsi,
> +					const struct dirent *addr_dir)
> +{
> +	struct sms_address addr;
> +	DECLARE_SMS_ADDR_STR(straddr);
> +	struct id_table_node *node;
> +	GHashTable *id_table;
> +	int r;
> +	char *assembly_table_key;
> +	unsigned int *id_table_key;
> +	DECLARE_SMS_MSGID_STR(str_msg_id);
> +	char *endp;
> +	unsigned int msg_id;
> +
> +	if (addr_dir->d_type !=3D DT_REG)
> +		return;
> +
> +	/*
> +	 * All SMS-messages under the same IMSI-code are
> +	 * included in the same directory.
> +	 * So, SMS-address and message ID are included in the same file name
> +	 * Max of SMS address size is 12 bytes, hex encoded
> +	 */
> +	if (sscanf(addr_dir->d_name, SMS_ADDR_FMT "-" SMS_MSGID_FMT,
> +				straddr, str_msg_id) < 2)
> +		return;

Using "-%u" should be sufficient here instead of SMS_MSGID_FMT.  Let us
hold off being too pedantic.  The directory is only readable / writeable
by root on properly configured systems, so we don't have to be too clever.

Also, we will be migrating away from unsigned int message ids to SHA-160
strings in the future, so lets not invest too much time getting this
part right.

> +
> +	if (sms_assembly_extract_address(straddr, &addr) =3D=3D FALSE)
> +		return;
> +

This looks fine...

> +	errno =3D 0;
> +	msg_id =3D strtoul(str_msg_id, &endp, 10);
> +
> +	if (*endp !=3D '\0')
> +		return;
> +
> +	if (errno =3D=3D ERANGE && msg_id =3D=3D UINT_MAX)
> +		return;
> +

So this part is no longer needed, remember to remove the errno.h include
above.

> +	id_table =3D g_hash_table_lookup(assembly_table,
> +					sms_address_to_string(&addr));
> +
> +	/* Create hashtable keyed by the to address if required */
> +	if (id_table =3D=3D NULL) {
> +		id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
> +							g_free, g_free);
> +
> +		assembly_table_key =3D g_strdup(sms_address_to_string(&addr));
> +		g_hash_table_insert(assembly_table, assembly_table_key,
> +					id_table);
> +	}
> +
> +	node =3D g_new0(struct id_table_node, 1);
> +
> +	r =3D read_file((unsigned char *) node,
> +			sizeof(struct id_table_node),
> +			SMS_SR_BACKUP_PATH "/%s",
> +			imsi, addr_dir->d_name);
> +
> +	if (r < 0) {
> +		g_free(node);
> +		return;
> +	}

So I suggest turning the order around here slightly.  If (id_table =3D=3D
NULL) and we fail to read the file, the assembly_table now has an
address hash table with no elements.

If we try to read the node first and fail, we won't have this issue.

> +
> +	/* Node ready, create key and add them to the table */
> +	id_table_key =3D g_new0(unsigned int, 1);
> +	*id_table_key =3D msg_id;
> +
> +	g_hash_table_insert(id_table, id_table_key, node);
> +}
> +
>  struct status_report_assembly *status_report_assembly_new(const char *im=
si)
>  {
> +	char *path;
> +	int len;
> +	struct dirent **addresses;
>  	struct status_report_assembly *ret =3D
>  				g_new0(struct status_report_assembly, 1);
>  =

>  	ret->assembly_table =3D g_hash_table_new_full(g_str_hash, g_str_equal,
>  				g_free, (GDestroyNotify)g_hash_table_destroy);
>  =

> -	if (imsi)
> +	if (imsi) {
>  		ret->imsi =3D imsi;
>  =

> +		/* Restore state from backup */
> +		path =3D g_strdup_printf(SMS_SR_BACKUP_PATH, imsi);
> +		len =3D scandir(path, &addresses, NULL, alphasort);
> +
> +		g_free(path);
> +
> +		if (len < 0)
> +			return ret;
> +
> +		/*
> +		 * Go through different addresses. Each address can relate to
> +		 * 1-n msg_ids.
> +		 */
> +
> +		while (len--) {
> +			sr_assembly_load_backup(ret->assembly_table, imsi,
> +								addresses[len]);
> +			g_free(addresses[len]);
> +		}
> +
> +		g_free(addresses);
> +	}
> +
>  	return ret;
>  }
>  =

> +static gboolean sr_assembly_add_fragment_backup(const char *imsi,
> +					const struct id_table_node *node,
> +					const struct sms_address *addr,
> +					unsigned int msg_id)
> +{
> +	int len =3D sizeof(struct id_table_node);
> +	DECLARE_SMS_ADDR_STR(straddr);
> +
> +	if (!imsi)
> +		return FALSE;
> +
> +	if (sms_address_to_hex_string(addr, straddr) =3D=3D FALSE)
> +		return FALSE;
> +
> +	/* storagedir/%s/sms_sr/%s-%i */
> +	if (write_file((unsigned char *) node, len, SMS_BACKUP_MODE,
> +			SMS_SR_BACKUP_PATH_FILE, imsi,
> +			straddr, msg_id) !=3D len)
> +		return FALSE;
> +
> +	return TRUE;
> +}
> +
> +static gboolean sr_assembly_remove_fragment_backup(const char *imsi,
> +					const struct id_table_node *node,
> +					const struct sms_address *addr,
> +					unsigned int msg_id)
> +{
> +	char *path;
> +	DECLARE_SMS_ADDR_STR(straddr);
> +
> +	if (!imsi)
> +		return FALSE;
> +
> +	if (sms_address_to_hex_string(addr, straddr) =3D=3D FALSE)
> +		return FALSE;
> +
> +	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi, straddr, msg_id=
);
> +
> +	unlink(path);
> +	g_free(path);
> +
> +	return TRUE;
> +}
> +
>  void status_report_assembly_free(struct status_report_assembly *assembly)
>  {
>  	g_hash_table_destroy(assembly->assembly_table);
> @@ -2698,6 +2846,7 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
>  	GHashTableIter iter;
>  	gboolean pending;
>  	int i;
> +	unsigned int msg_id;
>  =

>  	/* We ignore temporary or tempfinal status reports */
>  	if (sr_st_to_delivered(status_report->status_report.st,
> @@ -2743,14 +2892,30 @@ gboolean status_report_assembly_report(struct sta=
tus_report_assembly *assembly,
>  		}
>  	}
>  =

> -	if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE)
> +	msg_id =3D *(unsigned int *) key;
> +
> +	if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE) {
> +		/*
> +		 * More status reports expected, and already received
> +		 * reports completed. Update backup file.
> +		 */
> +		sr_assembly_add_fragment_backup(
> +					assembly->imsi, node,
> +					&status_report->status_report.raddr,
> +					msg_id);
> +
>  		return FALSE;
> +	}
>  =

>  	if (out_delivered)
>  		*out_delivered =3D node->deliverable;
>  =

>  	if (out_id)
> -		*out_id =3D *((unsigned int *) key);
> +		*out_id =3D msg_id;
> +
> +	sr_assembly_remove_fragment_backup(assembly->imsi, node,
> +					&status_report->status_report.raddr,
> +					msg_id);
>  =

>  	g_hash_table_iter_remove(&iter);
>  =

> @@ -2804,6 +2969,7 @@ void status_report_assembly_add_fragment(
>  	node->mrs[offset] |=3D bit;
>  	node->expiration =3D expiration;
>  	node->sent_mrs++;
> +	sr_assembly_add_fragment_backup(assembly->imsi, node, to, msg_id);
>  }
>  =

>  void status_report_assembly_expire(struct status_report_assembly *assemb=
ly,
> diff --git a/src/smsutil.h b/src/smsutil.h
> index eb70b6d..e5ef73a 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -370,7 +370,7 @@ struct id_table_node {
>  	unsigned char total_mrs;
>  	unsigned char sent_mrs;
>  	gboolean deliverable;
> -};
> +} __attribute__((packed));
>  =


Looks just fine to me...

>  struct status_report_assembly {
>  	const char *imsi;
> @@ -437,6 +437,14 @@ gboolean sms_encode(const struct sms *in, int *len, =
int *tpdu_len,
>   */
>  #define DECLARE_SMS_ADDR_STR(a) char a[25]
>  =

> +/*
> + * Length is based on the msg_id being 10 digits (max uint)
> + * plus a terminating NUL char. But for more detailed
> + * digit-verification, recerve space for 11 characters plus NUL char.
> + */
> +#define DECLARE_SMS_MSGID_STR(a) char a[12]
> +#define SMS_MSGID_FMT "%11s"
> +

As discussed above, lets remove this part.

As a general rule, if the define / enum / type does not need to be
exported for use by others, then it is preferable to keep it in the .c file.

>  gboolean sms_decode_address_field(const unsigned char *pdu, int len,
>  					int *offset, gboolean sc,
>  					struct sms_address *out);

Fix this up and lets get this stuff upstream and stress tested :)

Regards,
-Denis

--===============2484527681600727388==--

