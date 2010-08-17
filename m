Content-Type: multipart/mixed; boundary="===============0329794493451472550=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC_PATCH 2/4] smsutil: Editorial changes to sms status report
 function
Date: Tue, 17 Aug 2010 13:10:33 -0500
Message-ID: <4C6AD099.2080708@gmail.com>
In-Reply-To: <1281942533-9126-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0329794493451472550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 08/16/2010 02:08 AM, Petteri Tikander wrote:
> ---
>  src/smsutil.c |  202 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 198 insertions(+), 4 deletions(-)
> =


Can we change the commit message a bit, something about storing /
loading sms status report assemblies over reboots ;)

> diff --git a/src/smsutil.c b/src/smsutil.c
> index 22c70cf..0972988 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -45,6 +45,10 @@
>  #define SMS_BACKUP_PATH_DIR SMS_BACKUP_PATH "/%s-%i-%i"
>  #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
>  =

> +#define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
> +#define SMS_SR_BACKUP_PATH_DIR SMS_SR_BACKUP_PATH "/%s-%i-%i"
> +#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH_DIR "/%i"
> +
>  #define SMS_ADDR_FMT "%24[0-9A-F]"
>  =

>  static GSList *sms_assembly_add_fragment_backup(struct sms_assembly *ass=
embly,
> @@ -2642,20 +2646,204 @@ void sms_assembly_expire(struct sms_assembly *as=
sembly, time_t before)
>  	}
>  }
>  =

> +static void sr_assembly_load_backup(GHashTable *assembly_table,
> +					const char *imsi,
> +					const struct dirent *addr_dir)
> +{
> +	char *path;
> +	struct dirent **ids;
> +	struct sms_address sms_addr, *addr;
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
> +	addr =3D &sms_addr;
> +
> +	if (sscanf(addr_dir->d_name, SMS_ADDR_FMT "-%i-%i",
> +			addr->address, (int *) &addr->number_type,
> +			(int *) &addr->numbering_plan) < 3) {
> +		return;
> +	}

Lets follow what the sms_assembly does here.  Namely SMS_ADDR_FMT is
actually geared towards a hex-encoded address.  This already contains
the address, number_type and numbering_plan elements.  So simply using
sms_assembly_extract_address() afterwards is actually fine.  This has
the advantage of getting rid of the unnecessary casts.

> +
> +	/* Go through different msg_ids. */
> +	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s", imsi,
> +							addr_dir->d_name);
> +	len =3D scandir(path, &ids, NULL, versionsort);
> +
> +	g_free(path);
> +
> +	if (len < 0)
> +		return;
> +
> +	id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
> +							g_free, g_free);
> +
> +	assembly_table_key =3D g_try_malloc(sizeof(addr->address));
> +
> +	if (assembly_table_key =3D=3D NULL)
> +		return;
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
> +		memcpy(&node->to, addr, sizeof(*addr));

So I got rid of the node->to for now.  There's no reason to have it that
I can see...  Any time you are building / loading / accessing a node,
you actually know the current to address anyway.

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

To make our lives easier, I'd make the id_table_node structure packed
and read the data directly into it.  We don't have to worry about
byte-ordering at this point.

> +		/* Node ready, create key and add them to the table */
> +		id_table_key =3D g_new0(unsigned int, 1);
> +		*id_table_key =3D atoi(ids[len]->d_name);
> +
> +		g_hash_table_insert(id_table, id_table_key, node);
> +
> +		g_free(path);
> +		g_free(ids[len]);
> +	}
> +	g_free(ids);
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
> +		/* Go through different addresses. Each address can relate to
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

This looks just fine to me.

>  	return ret;
>  }
>  =

> +static gboolean sr_assembly_add_fragment_backup(const char *imsi,
> +					const struct id_table_node *node,
> +					unsigned int msg_id)
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

Again, simply writing the id_table_node structure might be easier here,
especially since you're not taking care of loading the expiration member.

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
>  void status_report_assembly_free(struct status_report_assembly *assembly)
>  {
>  	g_hash_table_destroy(assembly->assembly_table);
> @@ -2714,7 +2902,6 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
>  	g_hash_table_iter_init(&iter, id_table);
>  	while (g_hash_table_iter_next(&iter, &key, &value)) {
>  		node =3D value;
> -

Leave this empty line here, remember to check doc/coding-style.txt for a
reason why.

>  		if (node->mrs[offset] & bit)
>  			break;
>  =

> @@ -2724,7 +2911,6 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
>  	/* Unable to find a message reference belonging to this address */
>  	if (node =3D=3D NULL)
>  		return FALSE;
> -

Same comment as above.

>  	/* Mr belongs to this node. */
>  	node->mrs[offset] ^=3D bit;
>  =

> @@ -2743,8 +2929,12 @@ gboolean status_report_assembly_report(struct stat=
us_report_assembly *assembly,
>  		}
>  	}
>  =

> -	if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE)
> +	if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE) {
> +		sr_assembly_add_fragment_backup(assembly->imsi, node,
> +						*((unsigned int *) key));
> +
>  		return FALSE;
> +	}
>  =

>  	if (out_delivered)
>  		*out_delivered =3D node->deliverable;
> @@ -2752,6 +2942,9 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
>  	if (out_id)
>  		*out_id =3D *((unsigned int *) key);
>  =

> +	sr_assembly_remove_fragment_backup(assembly->imsi, node,
> +						*((unsigned int *) key));
> +

Honestly I'd like to see the cast done once and then used everywhere
afterwards.  Feel free to add an extra variable for this.

>  	g_hash_table_iter_remove(&iter);
>  =

>  	if (g_hash_table_size(id_table) =3D=3D 0)
> @@ -2805,6 +2998,7 @@ void status_report_assembly_add_fragment(
>  	node->mrs[offset] |=3D bit;
>  	node->expiration =3D expiration;
>  	node->sent_mrs++;
> +	sr_assembly_add_fragment_backup(assembly->imsi, node, msg_id);
>  }
>  =

>  void status_report_assembly_expire(struct status_report_assembly *assemb=
ly,

Regards,
-Denis

--===============0329794493451472550==--

