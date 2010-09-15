Content-Type: multipart/mixed; boundary="===============6087769884455053604=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/2] smsutil: national to international conversion in
 status report
Date: Wed, 15 Sep 2010 11:10:29 -0500
Message-ID: <4C90EFF5.3060709@gmail.com>
In-Reply-To: <1284535534-11426-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6087769884455053604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 09/15/2010 02:25 AM, Petteri Tikander wrote:
> ---
>  src/smsutil.c |   70 ++++++++++++++++++++++++++++++++++++++++++++-------=
-----
>  1 files changed, 55 insertions(+), 15 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index 26c7951..2d47289 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -2826,14 +2826,18 @@ gboolean status_report_assembly_report(struct sta=
tus_report_assembly *assembly,
>  	unsigned int offset =3D status_report->status_report.mr / 32;
>  	unsigned int bit =3D 1 << (status_report->status_report.mr % 32);
>  	struct id_table_node *node =3D NULL;
> -	const char *straddr;
> +	const char *straddr, *sent_addr;
> +	struct sms_address addr;
>  	GHashTable *id_table;
>  	gpointer key, value;
>  	gboolean delivered;
> -	GHashTableIter iter;
> +	GHashTableIter iter_addr, iter;
>  	gboolean pending;
>  	int i;
>  	unsigned int msg_id;
> +	unsigned int n_digits;
> +	unsigned int len_sent_addr;
> +	unsigned int len_rec_addr;
>  =

>  	/* We ignore temporary or tempfinal status reports */
>  	if (sr_st_to_delivered(status_report->status_report.st,
> @@ -2841,20 +2845,54 @@ gboolean status_report_assembly_report(struct sta=
tus_report_assembly *assembly,
>  		return FALSE;
>  =

>  	straddr =3D sms_address_to_string(&status_report->status_report.raddr);
> -	id_table =3D g_hash_table_lookup(assembly->assembly_table, straddr);
>  =

> -	/* key (receiver address) does not exist in assembly */
> -	if (id_table =3D=3D NULL)
> -		return FALSE;
> +	g_hash_table_iter_init(&iter_addr, assembly->assembly_table);
>  =

> -	g_hash_table_iter_init(&iter, id_table);
> -	while (g_hash_table_iter_next(&iter, &key, &value)) {
> -		node =3D value;

So my thinking is that for efficiency purposes we should try the direct
lookup first.  We don't want to pay the penalty of walking the entire
hash table every time for networks that are 'sane'.  If that fails, fall
back to the 'fuzzy' lookup.  This would also make the code a bit easier
to follow I think...

> +	/*
> +	 * Go through all addresses. Each address can relate to
> +	 * 1-n msg_ids.
> +	 */
> +	while (g_hash_table_iter_next(&iter_addr, (gpointer) &sent_addr,
> +					(gpointer) &id_table)) {
> +		/*
> +		 * Some networks can change address to international format,
> +		 * although address is sent in the national format.
> +		 * So notify this special case by checking only
> +		 * last six digits. If address contains less than six digits,
> +		 * compare only existing digits.
> +		 */
> +		if ((straddr[0] =3D=3D '+') && (sent_addr[0] !=3D '+')) {

In theory it could also be vice-versa...

> +			len_sent_addr =3D strlen(sent_addr);
> +			len_rec_addr =3D strlen(straddr);
> +			n_digits =3D (len_sent_addr > 6) ? 6 : len_sent_addr;
>  =

> -		if (node->mrs[offset] & bit)
> -			break;
> +			if (strcmp(&straddr[len_rec_addr - n_digits],
> +					&sent_addr[len_sent_addr - n_digits]))

Perhaps we should simply start at the last position of both strings and
compare in reverse.  If the match is MIN(6, strlen(sent_addr))
characters, then accept this as a 'fuzzy' match.

> +				continue;
> +		}
> +		/*
> +		 * In other cases the whole number received in the status report
> +		 * should match with the number originally sent.
> +		 */
> +		else if (strcmp(straddr, sent_addr))
> +				continue;
> +
> +		g_hash_table_iter_init(&iter, id_table);
> +		while (g_hash_table_iter_next(&iter, &key, &value)) {
> +			node =3D value;
> +
> +			if (node->mrs[offset] & bit)
> +				break;
>  =

> -		node =3D NULL;
> +			node =3D NULL;
> +		}
> +
> +		/*
> +		 * Received address with MR matched with one of the stored
> +		 * addresses and MR, so no need to continue searching.
> +		 */
> +		if (node)
> +			break;
>  	}
>  =

>  	/* Unable to find a message reference belonging to this address */
> @@ -2881,6 +2919,8 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
>  =

>  	msg_id =3D *(unsigned int *) key;
>  =

> +	sms_address_from_string(&addr, sent_addr);
> +
>  	if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE) {
>  		/*
>  		 * More status reports expected, and already received
> @@ -2888,7 +2928,7 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
>  		 */
>  		sr_assembly_add_fragment_backup(
>  					assembly->imsi, node,
> -					&status_report->status_report.raddr,
> +					&addr,
>  					msg_id);
>  =

>  		return FALSE;
> @@ -2901,14 +2941,14 @@ gboolean status_report_assembly_report(struct sta=
tus_report_assembly *assembly,
>  		*out_id =3D msg_id;
>  =

>  	sr_assembly_remove_fragment_backup(assembly->imsi,
> -					&status_report->status_report.raddr,
> +					&addr,
>  					msg_id);
>  =

>  	g_hash_table_iter_remove(&iter);
>  =

>  	if (g_hash_table_size(id_table) =3D=3D 0)
>  		g_hash_table_remove(assembly->assembly_table,
> -				status_report->status_report.raddr.address);
> +					sent_addr);
>  =

>  	return TRUE;
>  }

Otherwise it looks good.

Regards,
-Denis

--===============6087769884455053604==--

