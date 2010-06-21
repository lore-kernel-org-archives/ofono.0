Content-Type: multipart/mixed; boundary="===============2224868051031564385=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 5/5] smsutil: save pending status reports to imsi file
Date: Mon, 21 Jun 2010 16:07:45 -0500
Message-ID: <201006211607.45655.denkenz@gmail.com>
In-Reply-To: <1276780498-7573-6-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2224868051031564385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> ---
>  src/smsutil.c |  205
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 files =

changed,
>  204 insertions(+), 1 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index 3db3d28..a30a281 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -45,6 +45,10 @@
>  #define SMS_BACKUP_PATH_DIR SMS_BACKUP_PATH "/%s-%i-%i"
>  #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
> =

> +#define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
> +#define SMS_SR_BACKUP_PATH_DIR SMS_SR_BACKUP_PATH "/%s-%i-%i"
> +#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH_DIR "/%i"
> +
>  #define SMS_ADDR_FMT "%24[0-9A-F]"
> =

>  static GSList *sms_assembly_add_fragment_backup(struct sms_assembly
>  *assembly, @@ -2625,20 +2629,209 @@ void sms_assembly_expire(struct
>  sms_assembly *assembly, time_t before) }
>  }
> =

> +static void sr_assembly_load_backup(GHashTable *assembly_table,
> +					const char *imsi,
> +					const struct dirent *addr_dir)
> +{
> +	char *path;
> +	struct dirent **ids;
> +	struct sms_address *addr;
> +	struct id_table_node *node;
> +	GHashTable *id_table;
> +	int len;
> +	int r;
> +	unsigned char buf[sizeof(node->mrs) + sizeof(node->total_mrs) +
> +			sizeof(node->sent_mrs) + sizeof(node->deliverable)];
> +	char *assembly_table_key;
> +	unsigned int *id_table_key;
> +	struct stat segment_stat;
> +
> +	if (addr_dir->d_type !=3D DT_DIR)
> +		return;
> +
> +	addr =3D g_new0(struct sms_address, 1);

Why are you mallocing addr here? Seems that this only makes the code more =

complicated.

> +
> +	if (sscanf(addr_dir->d_name, "%[0-9]-%i-%i",
> +			addr->address, (int *) &addr->number_type,
> +			(int *) &addr->numbering_plan) < 3) {

Lets make this consistent with sms assembly, please use SMS_ADDR_FMT.  You'=
re =

also free to use sms_assembly utility functions if that helps you.

> +		g_free(addr);
> +		return;
> +	}
> +
> +	/* Go through different msg_ids. */
> +	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s", imsi,
> +							addr_dir->d_name);
> +	len =3D scandir(path, &ids, NULL, versionsort);
> +
> +	g_free(path);
> +
> +	if (len < 0) {
> +		g_free(addr);
> +		return;
> +	}
> +
> +	id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
> +							g_free, g_free);
> +
> +	assembly_table_key =3D g_try_malloc(sizeof(addr->address));
> +
> +	if (assembly_table_key =3D=3D NULL) {
> +		g_free(addr);
> +		return;
> +	}
> +
> +	g_strlcpy(assembly_table_key, addr->address, sizeof(addr->address));
> +	g_hash_table_insert(assembly_table, assembly_table_key, id_table);
> +
> +	while (len--) {
> +		path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s/%s",
> +				imsi, addr_dir->d_name, ids[len]->d_name);
> +		r =3D read_file(buf, sizeof(buf), SMS_SR_BACKUP_PATH "/%s/%s",
> +				imsi, addr_dir->d_name, ids[len]->d_name);
> +
> +		if (r < 0) {
> +			g_free(path);
> +			g_free(ids[len]);
> +			continue;
> +		}
> +
> +		r =3D stat(path, &segment_stat);
> +
> +		if (r !=3D 0) {
> +			g_free(path);
> +			g_free(ids[len]);
> +			continue;
> +		}
> +		/* Gather the data for id_table node */
> +		node =3D g_new0(struct id_table_node, 1);
> +		node->to =3D *addr;

Please use memcpy for copying structures.

> +		node->expiration =3D segment_stat.st_mtime;
> +		memcpy(node->mrs, buf, sizeof(node->mrs));
> +		memcpy(&node->total_mrs, buf + sizeof(node->mrs),
> +						sizeof(node->total_mrs));
> +		memcpy(&node->sent_mrs,
> +			buf + sizeof(node->mrs) + sizeof(node->total_mrs),
> +			sizeof(node->sent_mrs));
> +
> +		memcpy(&node->deliverable, buf + sizeof(node->mrs) +
> +			sizeof(node->total_mrs) + sizeof(node->sent_mrs),
> +			sizeof(node->deliverable));
> +		/* Node ready, create key and add them to the table */
> +		id_table_key =3D g_new0(unsigned int, 1);
> +		*id_table_key =3D atoi(ids[len]->d_name);
> +
> +		g_hash_table_insert(id_table, id_table_key, node);
> +
> +		g_free(path);
> +		g_free(ids[len]);
> +	}
> +	g_free(addr);
> +	g_free(ids);
> +}
> +

General comment here is that you're duplicating much of the code that inser=
ts =

the information into the data structure.  You can play the same trick as =

sms_assembly which uses a single function to do the heavy lifting, but take=
s =

an argument whether to store this info on disk.  Obviously during load you =

don't want to re-save this information on disk.  Then your load function =

becomes much smaller and easier to understand.

>  struct status_report_assembly *status_report_assembly_new(const char
>  *imsi) {
> +	char *path;
> +	int len;
> +	struct dirent **addresses;
>  	struct status_report_assembly *ret =3D
>  				g_new0(struct status_report_assembly, 1);
> =

>  	ret->assembly_table =3D g_hash_table_new_full(g_str_hash, g_str_equal,
>  				g_free, (GDestroyNotify)g_hash_table_destroy);
> =

> -	if (imsi)
> +	if (imsi) {
>  		ret->imsi =3D imsi;
> =

> +		/* Restore state from backup */
> +		path =3D g_strdup_printf(SMS_SR_BACKUP_PATH, imsi);
> +		len =3D scandir(path, &addresses, NULL, alphasort);
> +
> +		g_free(path);
> +
> +		if (len < 0)
> +			return ret;

There should be an empty line here

> +		/* Go through different addresses. Each address can relate to
> +		 * 1-n msg_ids. Do not try to load . and .. directories.
> +		 */
> +		g_free(addresses[0]);
> +		g_free(addresses[1]);

This really isn't necessary, the '.' and '..' directories will not pass the =

sscanf test above.

> +
> +		while (2 < len--) {
> +			sr_assembly_load_backup(ret->assembly_table, imsi,
> +								addresses[len]);
> +			g_free(addresses[len]);
> +		}

Empty line here please

> +		g_free(addresses);
> +	}

And another empty line here.  Please put an empty line after each block unl=
ess =

it is at the end of the function.
>  	return ret;
>  }
> =

> +static gboolean sr_assembly_add_fragment_backup(const char *imsi,
> +					const struct id_table_node *node,
> +					unsigned int msg_id)

Lets be consistent with how sms assembly works.  E.g. take the main assembl=
y =

object and return void.  Just helps to read the code when it is consistent.

> +{
> +	int len =3D sizeof(node->mrs) + sizeof(node->total_mrs) +
> +			sizeof(node->sent_mrs) + sizeof(node->deliverable);
> +	unsigned char buf[len];
> +
> +	if (!imsi)
> +		return FALSE;
> +
> +	memcpy(buf, node->mrs, sizeof(node->mrs));
> +
> +	memcpy(buf + sizeof(node->mrs), &node->total_mrs,
> +					sizeof(node->total_mrs));
> +
> +	memcpy(buf + sizeof(node->mrs) + sizeof(node->total_mrs),
> +				&node->sent_mrs, sizeof(node->sent_mrs));
> +
> +	memcpy(buf + sizeof(node->mrs) + sizeof(node->total_mrs) +
> +	sizeof(node->sent_mrs),	&node->deliverable, sizeof(node->deliverable));
> +
> +	/* storagedir/%s/sms_sr/%s-%i-%i/%i */
> +	if (write_file(buf, len, SMS_BACKUP_MODE, SMS_SR_BACKUP_PATH_FILE, imsi,
> +			node->to.address, node->to.number_type,
> +			node->to.numbering_plan, msg_id) !=3D len)
> +		return FALSE;
> +
> +	return TRUE;
> +}
> +
> +static gboolean sr_assembly_remove_fragment_backup(const char *imsi,
> +					const struct id_table_node *node,
> +					unsigned int msg_id)

Same consistency comment here.  Take main assembly object and return void.

> +{
> +	char *path;
> +
> +	if (!imsi)
> +		return FALSE;
> +
> +	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi, node->to.addres=
s,
> +				node->to.number_type, node->to.numbering_plan,
> +				msg_id);
> +
> +	unlink(path);
> +	g_free(path);
> +
> +	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, imsi, node->to.address,
> +				node->to.number_type, node->to.numbering_plan);
> +
> +	/* If the address does not have relating msg_ids anymore, remove it */
> +	rmdir(path);
> +	g_free(path);
> +
> +	return TRUE;
> +}
> +
> +static gboolean sr_assembly_update_fragment_backup(const char *imsi,
> +					const struct id_table_node *node,
> +					unsigned int msg_id)
> +{
> +	return sr_assembly_remove_fragment_backup(imsi, node, msg_id) &&
> +			sr_assembly_add_fragment_backup(imsi, node, msg_id);
> +}
> +

Is this function really necessary? write_file overwrites the file, so simpl=
y =

using add_fragment_backup seems sufficient.

>  void status_report_assembly_free(struct status_report_assembly *assembly)
>  {
>  	g_hash_table_destroy(assembly->assembly_table);
> @@ -2707,10 +2900,14 @@ gboolean status_report_assembly_report(struct
>  status_report_assembly *assembly, * not delete the node yet.
>  		 */
>  		if (pending) {
> +			sr_assembly_update_fragment_backup(assembly->imsi, node,
> +								*msg_id);

It seems to me fragment is the wrong name here.  What about =

'store_node_backup'?

>  			*msg_delivered =3D FALSE;
>  			return update_history;
>  		} else {
>  			*msg_delivered =3D node->deliverable;
> +			sr_assembly_remove_fragment_backup(assembly->imsi, node,
> +								*msg_id);

maybe 'remove_node_backup'

> =

>  			g_hash_table_iter_remove(&iter);
> =

> @@ -2747,6 +2944,7 @@ void status_report_assembly_add_fragment(
>  	unsigned int *id_table_key;
> =

>  	id_table =3D g_hash_table_lookup(assembly->assembly_table, to->address);
> +
>  	/* Create id_table and node */
>  	if (id_table =3D=3D NULL) {
>  		id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
> @@ -2775,6 +2973,9 @@ void status_report_assembly_add_fragment(
> =

>  		g_hash_table_insert(assembly->assembly_table,
>  					assembly_table_key, id_table);
> +
> +		sr_assembly_add_fragment_backup(assembly->imsi, node, msg_id);
> +
>  		return;
>  	}
> =

> @@ -2793,12 +2994,14 @@ void status_report_assembly_add_fragment(
>  		*id_table_key =3D msg_id;
>  		g_hash_table_insert(id_table, id_table_key, node);
> =

> +		sr_assembly_add_fragment_backup(assembly->imsi, node, msg_id);
>  		return;
>  	}
>  	/* id_table and node both exists */
>  	node->mrs[offset] |=3D bit;
>  	node->expiration =3D expiration;
>  	node->sent_mrs++;
> +	sr_assembly_update_fragment_backup(assembly->imsi, node, msg_id);
>  }
> =

>  void status_report_assembly_expire(struct status_report_assembly
>  *assembly,
> =


Regards,
-Denis

--===============2224868051031564385==--

