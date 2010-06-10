Content-Type: multipart/mixed; boundary="===============0045613075727172468=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/2] smsutil: Status Report assembly
Date: Thu, 10 Jun 2010 11:52:46 -0500
Message-ID: <201006101152.46861.denkenz@gmail.com>
In-Reply-To: <1276153545-22260-2-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0045613075727172468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> +void status_report_assembly_free(struct status_report_assembly *assembly)
> +{
> +	g_hash_table_destroy(assembly->assembly_table);

You should also be g_freeing the assembly structure itself.  In general, it=
 is =

a very good idea to run valgrind --leak-check=3Dfull on the modified binary =

before submitting any patches upstream.  This helps to identify such issues =

early.

And did I mention unit tests? :)

> +}
> +
> +enum ofono_history_sms_status status_report_assembly_report(
> +					struct status_report_assembly *assembly,
> +					const struct sms *status_report,
> +					unsigned int *msg_id)
> +{
> +	unsigned int offset =3D status_report->status_report.mr / 32;
> +	unsigned int bit =3D 1 << (status_report->status_report.mr % 32);
> +	GHashTable *id_table;
> +	struct id_table_node *node =3D NULL;

There's no need to initialize this to NULL.

> +	gpointer key;
> +	gpointer value;
> +	GHashTableIter iter;
> +	int i;
> +
> +	id_table =3D g_hash_table_lookup(assembly->assembly_table,
> +				status_report->status_report.raddr.address);
> +
> +	/* ERROR, key (receiver address) does not exist in assembly*/
> +	if (!id_table)
> +		return OFONO_HISTORY_SMS_STATUS_ERROR;
> +
> +	g_hash_table_iter_init(&iter, id_table);
> +	while (g_hash_table_iter_next(&iter, &key, &value)) {
> +		node =3D value;
> +
> +		if (!(node->mrs[offset] & bit))
> +			continue;
> +
> +		if (status_report->status_report.st =3D=3D
> +						SMS_ST_COMPLETED_RECEIVED) {
> +			/* mr belongs to this node */
> +			node->mrs[offset] ^=3D bit;
> +			*msg_id =3D node->ofono_msg_id;
> +
> +			for (i =3D 0; i < 8; i++) {
> +				/* There are still pending mr(s). */
> +				if (node->mrs[i] !=3D 0)
> +					return OFONO_HISTORY_SMS_STATUS_PENDING;
> +			}
> +		}
> +		/* No more pending mrs for this node. Remove node from id_table
> +		 * and free it.
> +		 */
> +		g_hash_table_iter_remove(&iter);
> +		/* id_list empty, remove key and value from assembly_table */
> +		if (g_hash_table_size(id_table) =3D=3D 0)
> +			g_hash_table_remove(assembly->assembly_table,
> +				status_report->status_report.raddr.address);
> +
> +		return OFONO_HISTORY_SMS_STATUS_DELIVERED;

You're marking this message as delivered even if a failure status report wa=
s =

sent.  Also, in the case of a failure, you're not providing the message id.

> +void status_report_assembly_add_fragment(struct status_report_assembly
> +					*assembly, unsigned int *msg_id,

Please don't put the assembly on a separate line.  The var name should be o=
n =

the same line as the type.

msg_id should simply be unsigned int msg_id.  This is not an in/out argumen=
t.

> +					struct sms_address *to,

const struct sms_address *to please.

> +					unsigned char mr, time_t expiration)
> +{
> +	unsigned int offset =3D mr / 32;
> +	unsigned int bit =3D 1 << (mr % 32);
> +	GHashTable *id_table;
> +	struct id_table_node *node;
> +	char *assembly_table_key;
> +	unsigned int *id_table_key;
> +
> +	id_table =3D g_hash_table_lookup(assembly->assembly_table, to->address);

I'd structure the code like this:
if (id_table =3D=3D NULL) {
 what is in the ... else clause
 return;
}

node =3D g_hash_table_lookup();

if (node) {
return;
}

...

This makes the code much more readable.  In general, avoid nested if =

statements if possible.

> +
> +	if (id_table) {
> +		node =3D g_hash_table_lookup(id_table, msg_id);
> +
> +		if (node) {
> +			node->mrs[offset] |=3D bit;
> +			node->expiration =3D expiration;
> +		} else {
> +			id_table_key =3D g_new0(unsigned int, 1);
> +			node =3D g_new0(struct id_table_node, 1);
> +			node->to =3D *to;
> +			node->ofono_msg_id =3D *msg_id;
> +			node->mrs[offset] |=3D bit;
> +			node->expiration =3D expiration;
> +
> +			*id_table_key =3D *msg_id;
> +			g_hash_table_insert(id_table, id_table_key, node);
> +		}
> +	} else {
> +		id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
> +								g_free, g_free);
> +		id_table_key =3D g_new0(unsigned int, 1);
> +
> +		node =3D g_new0(struct id_table_node, 1);
> +		node->to =3D *to;
> +		node->ofono_msg_id =3D *msg_id;
> +		node->mrs[offset] |=3D bit;
> +		node->expiration =3D expiration;
> +
> +		*id_table_key =3D *msg_id;
> +		g_hash_table_insert(id_table, id_table_key, node);
> +
> +		assembly_table_key =3D g_try_malloc(sizeof(to->address));
> +
> +		if (assembly_table_key =3D=3D NULL)
> +			return;
> +
> +		g_strlcpy(assembly_table_key, to->address, sizeof(to->address));
> +
> +		g_hash_table_insert(assembly->assembly_table,
> +					assembly_table_key, id_table);
> +	}

I see one problem with this function, namely that under some bizarre =

circumstances, the status report might come back before additional fragment=
s =

have been added.  So this function should also take a num_fragments argumen=
t =

and keep track of how many fragment status reports were actually received.

This gets a bit tricky when a failure is reported before the entire set of =

fragments has been submitted...

> +struct id_table_node {
> +	struct sms_address to;
> +	unsigned int ofono_msg_id;

Why are you storing the message id when it is also the key for the hash tab=
le?

> +	unsigned int mrs[8];
> +	time_t expiration;
> +};
> +

Regards,
-Denis

--===============0045613075727172468==--

