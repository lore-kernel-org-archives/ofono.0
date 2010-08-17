Content-Type: multipart/mixed; boundary="===============0232442449642864423=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC_PATCH 4/4] smsutil: added function for data handling of
 status report
Date: Tue, 17 Aug 2010 14:07:03 -0500
Message-ID: <4C6ADDD7.5010300@gmail.com>
In-Reply-To: <1281942533-9126-4-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0232442449642864423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 08/16/2010 02:08 AM, Petteri Tikander wrote:
> ---
>  src/smsutil.c |  158 +++++++++++++++++++++++++++++++++------------------=
------
>  1 files changed, 92 insertions(+), 66 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index 25e405c..a12bede 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -57,6 +57,15 @@ static GSList *sms_assembly_add_fragment_backup(struct=
 sms_assembly *assembly,
>  					guint16 ref, guint8 max, guint8 seq,
>  					gboolean backup);
>  =

> +static void sr_assembly_add_fragment_backup(
> +					struct status_report_assembly *assembly,
> +					unsigned int msg_id, time_t ts,
> +					const struct sms_address *to,
> +					unsigned int *mrs,
> +					unsigned char total_mrs,
> +					unsigned char sent_mrs,
> +					gboolean backup);
> +

Please avoid forward-declarations unless absolutely necessary.  It is
better to just move the function upwards.

>  /*
>   * This function uses the meanings of digits 10..15 according to the rul=
es
>   * defined in 23.040 Section 9.1.2.3 and 24.008 Table 10.5.118
> @@ -2646,22 +2655,19 @@ void sms_assembly_expire(struct sms_assembly *ass=
embly, time_t before)
>  	}
>  }
>  =

> -static void sr_assembly_load_backup(GHashTable *assembly_table,
> -					const char *imsi,
> -					const struct dirent *addr_dir)
> +static void sr_assembly_load_backup(
> +				struct status_report_assembly *assembly_table,
> +				const struct dirent *addr_dir)
>  {
>  	char *path;
>  	struct dirent **ids;
>  	struct sms_address addr;
>  	DECLARE_SMS_ADDR_STR(straddr);
>  	struct id_table_node *node;
> -	GHashTable *id_table;
>  	int len;
>  	int r;
>  	unsigned char buf[sizeof(node->mrs) + sizeof(node->total_mrs) +
>  			sizeof(node->sent_mrs) + sizeof(node->deliverable)];
> -	char *assembly_table_key;
> -	unsigned int *id_table_key;
>  	struct stat segment_stat;
>  =

>  	if (addr_dir->d_type !=3D DT_DIR)
> @@ -2675,7 +2681,7 @@ static void sr_assembly_load_backup(GHashTable *ass=
embly_table,
>  		return;
>  =

>  	/* Go through different msg_ids. */
> -	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s", imsi,
> +	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s", assembly_table->imsi,
>  							addr_dir->d_name);
>  	len =3D scandir(path, &ids, NULL, versionsort);
>  =

> @@ -2684,22 +2690,13 @@ static void sr_assembly_load_backup(GHashTable *a=
ssembly_table,
>  	if (len < 0)
>  		return;
>  =

> -	id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
> -							g_free, g_free);
> -
> -	assembly_table_key =3D g_try_malloc(sizeof(addr.address));
> -
> -	if (assembly_table_key =3D=3D NULL)
> -		return;
> -
> -	g_strlcpy(assembly_table_key, addr.address, sizeof(addr.address));
> -	g_hash_table_insert(assembly_table, assembly_table_key, id_table);
> -
>  	while (len--) {
>  		path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s/%s",
> -				imsi, addr_dir->d_name, ids[len]->d_name);
> +				assembly_table->imsi, addr_dir->d_name,
> +				ids[len]->d_name);
>  		r =3D read_file(buf, sizeof(buf), SMS_SR_BACKUP_PATH "/%s/%s",
> -				imsi, addr_dir->d_name, ids[len]->d_name);
> +				assembly_table->imsi, addr_dir->d_name,
> +				ids[len]->d_name);
>  =

>  		if (r < 0) {
>  			g_free(path);
> @@ -2714,29 +2711,21 @@ static void sr_assembly_load_backup(GHashTable *a=
ssembly_table,
>  			g_free(ids[len]);
>  			continue;
>  		}
> -		/* Gather the data for id_table node */
> -		node =3D g_new0(struct id_table_node, 1);
> -		memcpy(&node->to, &addr, sizeof(addr));
> -		node->expiration =3D segment_stat.st_mtime;
> -		memcpy(node->mrs, buf, sizeof(node->mrs));
> -		memcpy(&node->total_mrs, buf + sizeof(node->mrs),
> -						sizeof(node->total_mrs));
> -		memcpy(&node->sent_mrs,
> -			buf + sizeof(node->mrs) + sizeof(node->total_mrs),
> -			sizeof(node->sent_mrs));
> -
> -		memcpy(&node->deliverable, buf + sizeof(node->mrs) +
> -			sizeof(node->total_mrs) + sizeof(node->sent_mrs),
> -			sizeof(node->deliverable));
> -		/* Node ready, create key and add them to the table */
> -		id_table_key =3D g_new0(unsigned int, 1);
> -		*id_table_key =3D atoi(ids[len]->d_name);
>  =

> -		g_hash_table_insert(id_table, id_table_key, node);
> +		sr_assembly_add_fragment_backup(assembly_table,
> +						atoi(ids[len]->d_name),
> +						segment_stat.st_mtime,
> +						&addr,
> +						(unsigned int *) &buf[0],
> +						buf[sizeof(node->mrs)],
> +						buf[sizeof(node->mrs) +
> +						sizeof(node->total_mrs)],
> +						FALSE);
>  =


If we can write / read the node structure directly, then I'm actually
thinking we won't be needing this patch at all.

>  		g_free(path);
>  		g_free(ids[len]);
>  	}
> +
>  	g_free(ids);
>  }
>  =

> @@ -2767,8 +2756,7 @@ struct status_report_assembly *status_report_assemb=
ly_new(const char *imsi)
>  		 * 1-n msg_ids.
>  		 */
>  		while (len--) {
> -			sr_assembly_load_backup(ret->assembly_table, imsi,
> -								addresses[len]);
> +			sr_assembly_load_backup(ret, addresses[len]);
>  			g_free(addresses[len]);
>  		}
>  =

> @@ -2778,16 +2766,17 @@ struct status_report_assembly *status_report_asse=
mbly_new(const char *imsi)
>  	return ret;
>  }
>  =

> -static gboolean sr_assembly_add_fragment_backup(const char *imsi,
> -					const struct id_table_node *node,
> -					unsigned int msg_id)
> +static gboolean sr_assembly_backup_store(
> +				struct status_report_assembly *assembly,
> +				const struct id_table_node *node,
> +				unsigned int msg_id)
>  {
>  	int len =3D sizeof(node->mrs) + sizeof(node->total_mrs) +
>  			sizeof(node->sent_mrs) + sizeof(node->deliverable);
>  	unsigned char buf[len];
>  	DECLARE_SMS_ADDR_STR(straddr);
>  =

> -	if (!imsi)
> +	if (!assembly->imsi)
>  		return FALSE;
>  =

>  	if (sms_address_to_hex_string(&node->to, straddr) =3D=3D FALSE)
> @@ -2805,32 +2794,35 @@ static gboolean sr_assembly_add_fragment_backup(c=
onst char *imsi,
>  	sizeof(node->sent_mrs),	&node->deliverable, sizeof(node->deliverable));
>  =

>  	/* storagedir/%s/sms_sr/%s/%i */
> -	if (write_file(buf, len, SMS_BACKUP_MODE, SMS_SR_BACKUP_PATH_FILE, imsi,
> +	if (write_file(buf, len, SMS_BACKUP_MODE,
> +			SMS_SR_BACKUP_PATH_FILE, assembly->imsi,
>  			straddr, msg_id) !=3D len)
>  		return FALSE;
>  =

>  	return TRUE;
>  }
>  =

> -static gboolean sr_assembly_remove_fragment_backup(const char *imsi,
> +static gboolean sr_assembly_backup_free(struct status_report_assembly *a=
ssembly,
>  					const struct id_table_node *node,
>  					unsigned int msg_id)
>  {
>  	char *path;
>  	DECLARE_SMS_ADDR_STR(straddr);
>  =

> -	if (!imsi)
> +	if (!assembly->imsi)
>  		return FALSE;
>  =

>  	if (sms_address_to_hex_string(&node->to, straddr) =3D=3D FALSE)
>  		return FALSE;
>  =

> -	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi, straddr, msg_id=
);
> +	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, assembly->imsi,
> +				straddr, msg_id);
>  =

>  	unlink(path);
>  	g_free(path);
>  =

> -	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, imsi, straddr);
> +	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, assembly->imsi,
> +				straddr);
>  =

>  	/* If the address does not have relating msg_ids anymore, remove it */
>  	rmdir(path);
> @@ -2928,8 +2920,8 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
>  		/* More status reports expected, and already received
>  		   reports completed. Update backup file.
>  		 */
> -		sr_assembly_add_fragment_backup(assembly->imsi, node,
> -						*((unsigned int *) key));
> +		sr_assembly_backup_store(assembly, node,
> +					 *((unsigned int *) key));
>  =

>  		return FALSE;
>  	}
> @@ -2940,8 +2932,7 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
>  	if (out_id)
>  		*out_id =3D *((unsigned int *) key);
>  =

> -	sr_assembly_remove_fragment_backup(assembly->imsi, node,
> -						*((unsigned int *) key));
> +	sr_assembly_backup_free(assembly, node,	*((unsigned int *) key));
>  =

>  	g_hash_table_iter_remove(&iter);
>  =

> @@ -2952,18 +2943,18 @@ gboolean status_report_assembly_report(struct sta=
tus_report_assembly *assembly,
>  	return TRUE;
>  }
>  =

> -void status_report_assembly_add_fragment(
> -					struct status_report_assembly *assembly,
> -					unsigned int msg_id,
> -					const struct sms_address *to,
> -					unsigned char mr, time_t expiration,
> -					unsigned char total_mrs)
> +static void sr_assembly_add_fragment_backup(
> +				struct status_report_assembly *assembly,
> +				unsigned int msg_id, time_t ts,
> +				const struct sms_address *to,
> +				unsigned int *mrs, unsigned char total_mrs,
> +				unsigned char sent_mrs, gboolean backup)
>  {
> -	unsigned int offset =3D mr / 32;
> -	unsigned int bit =3D 1 << (mr % 32);
>  	GHashTable *id_table;
>  	struct id_table_node *node;
>  	unsigned int *id_table_key;
> +	int i;
> +	int len =3D sizeof(node->mrs) / sizeof(node->mrs[0]);
>  =

>  	id_table =3D g_hash_table_lookup(assembly->assembly_table,
>  					sms_address_to_string(to));
> @@ -2971,7 +2962,7 @@ void status_report_assembly_add_fragment(
>  	/* Create hashtable keyed by the to address if required */
>  	if (id_table =3D=3D NULL) {
>  		id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
> -								g_free, g_free);
> +						g_free, g_free);
>  		g_hash_table_insert(assembly->assembly_table,
>  					g_strdup(sms_address_to_string(to)),
>  					id_table);
> @@ -2993,10 +2984,45 @@ void status_report_assembly_add_fragment(
>  	}
>  =

>  	/* id_table and node both exists */
> -	node->mrs[offset] |=3D bit;
> -	node->expiration =3D expiration;
> -	node->sent_mrs++;
> -	sr_assembly_add_fragment_backup(assembly->imsi, node, msg_id);
> +
> +	for (i =3D 0; i < len; i++)
> +		node->mrs[i] |=3D mrs[i];
> +
> +	node->expiration =3D ts;
> +
> +	/* storing to the backup-file is needed, when new SMS-message is sent */
> +	if (backup) {
> +		node->sent_mrs++;
> +		sr_assembly_backup_store(assembly, node, msg_id);
> +	}
> +	/* storing to the backup-file is not needed, when backup is loaded */
> +	else
> +		node->sent_mrs =3D sent_mrs;
> +}
> +
> +void status_report_assembly_add_fragment(
> +				struct status_report_assembly *assembly,
> +				unsigned int msg_id,
> +				const struct sms_address *to,
> +				unsigned char mr, time_t expiration,
> +				unsigned char total_mrs)
> +{
> +	struct id_table_node *node;
> +	unsigned int offset =3D mr / 32;
> +	unsigned int bit =3D 1 << (mr % 32);
> +	int len =3D sizeof(node->mrs) / sizeof(node->mrs[0]);
> +	unsigned int mrs[len];
> +
> +	memset(mrs, 0, len);
> +
> +	/* set correct bit corresponding to the
> +	 *  received mr-number in mr-buffer
> +	 */
> +	mrs[offset] |=3D bit;
> +

The memset above and this looks fishy to me...

> +	sr_assembly_add_fragment_backup(assembly, msg_id, expiration,
> +					to, mrs, total_mrs,
> +					FALSE, TRUE);
>  }
>  =

>  void status_report_assembly_expire(struct status_report_assembly *assemb=
ly,

Regards,
-Denis

--===============0232442449642864423==--

