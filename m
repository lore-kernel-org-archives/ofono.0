Content-Type: multipart/mixed; boundary="===============6817375590466607851=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC_PATCH 3/4] smsutil:add proper checking of sms-address in
 status report-function
Date: Tue, 17 Aug 2010 13:16:26 -0500
Message-ID: <4C6AD1FA.3050504@gmail.com>
In-Reply-To: <1281942533-9126-3-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6817375590466607851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 08/16/2010 02:08 AM, Petteri Tikander wrote:
> ---
>  src/smsutil.c |   54 ++++++++++++++++++++++++++-------------------------=
---
>  1 files changed, 26 insertions(+), 28 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index 0972988..25e405c 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -46,7 +46,7 @@
>  #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
>  =

>  #define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
> -#define SMS_SR_BACKUP_PATH_DIR SMS_SR_BACKUP_PATH "/%s-%i-%i"
> +#define SMS_SR_BACKUP_PATH_DIR SMS_SR_BACKUP_PATH "/%s"

Aha you're already following my comments from last patch :)  Can you
please modify the previous patch to include this change?

>  #define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH_DIR "/%i"
>  =

>  #define SMS_ADDR_FMT "%24[0-9A-F]"
> @@ -2417,7 +2417,7 @@ static void sms_assembly_backup_free(struct sms_ass=
embly *assembly,
>  {
>  	char *path;
>  	int seq;
> -	char straddr[25];
> +	DECLARE_SMS_ADDR_STR(straddr);

Same comment as above, squish into previous patch.

>  =

>  	if (!assembly->imsi)
>  		return;
> @@ -2652,7 +2652,8 @@ static void sr_assembly_load_backup(GHashTable *ass=
embly_table,
>  {
>  	char *path;
>  	struct dirent **ids;
> -	struct sms_address sms_addr, *addr;
> +	struct sms_address addr;
> +	DECLARE_SMS_ADDR_STR(straddr);

Here as well, squish into previous patch.

>  	struct id_table_node *node;
>  	GHashTable *id_table;
>  	int len;
> @@ -2666,13 +2667,12 @@ static void sr_assembly_load_backup(GHashTable *a=
ssembly_table,
>  	if (addr_dir->d_type !=3D DT_DIR)
>  		return;
>  =

> -	addr =3D &sms_addr;
> +	/* Max of SMS address size is 12 bytes, hex encoded */
> +	if (sscanf(addr_dir->d_name, SMS_ADDR_FMT, straddr) < 1)
> +		return;
>  =

> -	if (sscanf(addr_dir->d_name, SMS_ADDR_FMT "-%i-%i",
> -			addr->address, (int *) &addr->number_type,
> -			(int *) &addr->numbering_plan) < 3) {
> +	if (sms_assembly_extract_address(straddr, &addr) =3D=3D FALSE)
>  		return;
> -	}

And here

>  =

>  	/* Go through different msg_ids. */
>  	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s", imsi,
> @@ -2687,12 +2687,12 @@ static void sr_assembly_load_backup(GHashTable *a=
ssembly_table,
>  	id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
>  							g_free, g_free);
>  =

> -	assembly_table_key =3D g_try_malloc(sizeof(addr->address));
> +	assembly_table_key =3D g_try_malloc(sizeof(addr.address));
>  =

>  	if (assembly_table_key =3D=3D NULL)
>  		return;
>  =

> -	g_strlcpy(assembly_table_key, addr->address, sizeof(addr->address));
> +	g_strlcpy(assembly_table_key, addr.address, sizeof(addr.address));
>  	g_hash_table_insert(assembly_table, assembly_table_key, id_table);

g_strdup(sms_address_to_string(&addr)) seems better.  Squish this one
into the previous patch as well.

>  =

>  	while (len--) {
> @@ -2716,7 +2716,7 @@ static void sr_assembly_load_backup(GHashTable *ass=
embly_table,
>  		}
>  		/* Gather the data for id_table node */
>  		node =3D g_new0(struct id_table_node, 1);
> -		memcpy(&node->to, addr, sizeof(*addr));
> +		memcpy(&node->to, &addr, sizeof(addr));
>  		node->expiration =3D segment_stat.st_mtime;
>  		memcpy(node->mrs, buf, sizeof(node->mrs));
>  		memcpy(&node->total_mrs, buf + sizeof(node->mrs),
> @@ -2766,7 +2766,6 @@ struct status_report_assembly *status_report_assemb=
ly_new(const char *imsi)
>  		/* Go through different addresses. Each address can relate to
>  		 * 1-n msg_ids.
>  		 */
> -

Again, please leave this newline here.

>  		while (len--) {
>  			sr_assembly_load_backup(ret->assembly_table, imsi,
>  								addresses[len]);
> @@ -2786,10 +2785,14 @@ static gboolean sr_assembly_add_fragment_backup(c=
onst char *imsi,
>  	int len =3D sizeof(node->mrs) + sizeof(node->total_mrs) +
>  			sizeof(node->sent_mrs) + sizeof(node->deliverable);
>  	unsigned char buf[len];
> +	DECLARE_SMS_ADDR_STR(straddr);
>  =

>  	if (!imsi)
>  		return FALSE;
>  =

> +	if (sms_address_to_hex_string(&node->to, straddr) =3D=3D FALSE)
> +		return FALSE;
> +

And squish here as well..

>  	memcpy(buf, node->mrs, sizeof(node->mrs));
>  =

>  	memcpy(buf + sizeof(node->mrs), &node->total_mrs,
> @@ -2801,10 +2804,9 @@ static gboolean sr_assembly_add_fragment_backup(co=
nst char *imsi,
>  	memcpy(buf + sizeof(node->mrs) + sizeof(node->total_mrs) +
>  	sizeof(node->sent_mrs),	&node->deliverable, sizeof(node->deliverable));
>  =

> -	/* storagedir/%s/sms_sr/%s-%i-%i/%i */
> +	/* storagedir/%s/sms_sr/%s/%i */
>  	if (write_file(buf, len, SMS_BACKUP_MODE, SMS_SR_BACKUP_PATH_FILE, imsi,
> -			node->to.address, node->to.number_type,
> -			node->to.numbering_plan, msg_id) !=3D len)
> +			straddr, msg_id) !=3D len)

And here

>  		return FALSE;
>  =

>  	return TRUE;
> @@ -2815,19 +2817,20 @@ static gboolean sr_assembly_remove_fragment_backu=
p(const char *imsi,
>  					unsigned int msg_id)
>  {
>  	char *path;
> +	DECLARE_SMS_ADDR_STR(straddr);
>  =

>  	if (!imsi)
>  		return FALSE;
>  =

> -	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi, node->to.addres=
s,
> -				node->to.number_type, node->to.numbering_plan,
> -				msg_id);
> +	if (sms_address_to_hex_string(&node->to, straddr) =3D=3D FALSE)
> +		return FALSE;
> +
> +	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi, straddr, msg_id=
);
>  =

>  	unlink(path);
>  	g_free(path);
>  =

> -	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, imsi, node->to.address,
> -				node->to.number_type, node->to.numbering_plan);
> +	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, imsi, straddr);

And squish this chunk into previous as well.

>  =

>  	/* If the address does not have relating msg_ids anymore, remove it */
>  	rmdir(path);
> @@ -2836,14 +2839,6 @@ static gboolean sr_assembly_remove_fragment_backup=
(const char *imsi,
>  	return TRUE;
>  }
>  =

> -static gboolean sr_assembly_update_fragment_backup(const char *imsi,
> -					const struct id_table_node *node,
> -					unsigned int msg_id)
> -{
> -	return sr_assembly_remove_fragment_backup(imsi, node, msg_id) &&
> -			sr_assembly_add_fragment_backup(imsi, node, msg_id);
> -}
> -

Simply removing this function from the previous patch is better.

>  void status_report_assembly_free(struct status_report_assembly *assembly)
>  {
>  	g_hash_table_destroy(assembly->assembly_table);
> @@ -2930,6 +2925,9 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
>  	}
>  =

>  	if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE) {
> +		/* More status reports expected, and already received
> +		   reports completed. Update backup file.
> +		 */

Please update this comment based on the coding style guidelines.  For
multi line comments we prefer

/*
 * Comment line 1...
 * Comment line 2...
 */

>  		sr_assembly_add_fragment_backup(assembly->imsi, node,
>  						*((unsigned int *) key));
>  =


Regards,
-Denis

--===============6817375590466607851==--

