Content-Type: multipart/mixed; boundary="===============0231328701662941919=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3][RfC] Add utilities for encoding BTLVs and CTLVs.
Date: Fri, 23 Apr 2010 15:09:19 -0500
Message-ID: <201004231509.20187.denkenz@gmail.com>
In-Reply-To: <1271923900-3349-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0231328701662941919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> +gboolean ber_tlv_constr_init(struct ber_tlv_constr *constr,
> +				unsigned char *pdu, unsigned int size)
> +{
> +	if (size < 2)
> +		return FALSE;
> +
> +	constr->pdu =3D pdu;
> +	constr->pos =3D 0;
> +	constr->max =3D size;
> +	constr->parent =3D NULL;
> +
> +	return TRUE;
> +}

So I think for the case of the encoder we should bite the bullet and use =

something like a g_byte_array.  It will be really hard for us to guess the =

correct buffer size.

> +/* Resize the TLV because the content of Value field needs more space.  =
If
> + * this TLV is part of another TLV, resize that one too.  */
> +static unsigned char *ber_tlv_constr_update_len(struct ber_tlv_constr
>  *constr, +						unsigned int new_len,
> +						unsigned int pos)
> +{
> +	unsigned char *tlv =3D constr->pdu + pos;
> +	unsigned int taglen =3D ber_tlv_get_tag_len(tlv);
> +	unsigned int lenlen =3D 1, new_lenlen =3D 1;
> +	unsigned int len =3D tlv[taglen];
> +	unsigned int tlv_len, new_tlv_len;
> +	unsigned int added_len =3D 0;
> +
> +	/* How much space do we occupy now */
> +	if (len >=3D 0x80) {
> +		unsigned int extended_bytes =3D len - 0x80;
> +		unsigned int i;
> +
> +		for (len =3D 0, i =3D 1; i <=3D extended_bytes; i++)
> +			len =3D (len << 8) |
> +				tlv[taglen + i];
> +
> +		lenlen +=3D extended_bytes;
> +	}
> +
> +	tlv_len =3D taglen + lenlen + len;
> +
> +	/* How much do we need */
> +	if (new_len >=3D 0x80) {
> +		unsigned int extended_bytes =3D 0;
> +		while (new_len >> (extended_bytes * 8))
> +			extended_bytes +=3D 1;
> +		new_lenlen +=3D extended_bytes;
> +	}
> +
> +	new_tlv_len =3D taglen + new_lenlen + new_len;
> +
> +	/* Check there is enough space */
> +	if (constr->pos > pos)
> +		added_len =3D constr->pos - (pos + tlv_len);
> +
> +	if (pos + new_tlv_len + added_len > constr->max)
> +		return NULL;
> +
> +	if (constr->parent) {
> +		unsigned char *new_pdu =3D ber_tlv_constr_update_len(
> +						constr->parent,
> +						pos + new_tlv_len + added_len,
> +						constr->parent_pos);
> +		if (new_pdu =3D=3D NULL)
> +			return NULL;
> +
> +		constr->pdu =3D new_pdu;
> +		tlv =3D constr->pdu + pos;
> +	}
> +
> +	if (added_len > 0 && new_tlv_len !=3D tlv_len) {
> +		memmove(tlv + new_tlv_len, tlv + tlv_len, added_len);
> +		constr->pos +=3D new_tlv_len - tlv_len;
> +	}
> +
> +	if (new_lenlen !=3D lenlen)
> +		memmove(tlv + taglen + new_lenlen, tlv + taglen + lenlen,
> +				tlv_len);
> +
> +	/* Write new length */
> +	if (new_len < 0x80)
> +		tlv[taglen] =3D new_len;
> +	else {
> +		unsigned int extended_bytes =3D 0;
> +		unsigned int i;
> +		while (new_len >> (extended_bytes * 8))
> +			extended_bytes +=3D 1;
> +
> +		for (i =3D 1; i <=3D extended_bytes; i++)
> +			tlv[taglen + i] =3D
> +				(new_len >> ((extended_bytes - i) * 8)) & 0xff;
> +
> +		tlv[taglen] =3D 0x80 + extended_bytes;
> +	}
> +
> +	return tlv + taglen + new_lenlen;
> +}

Let me propose something, tell me if this can be made to work potentially m=
ore =

efficiently:

- When we init a ber_tlv, reserve a header at the beginning of the buffer t=
o =

the max size of the tag + length.  The data with CTLVs will be written afte=
r =

that header.
- When we allocate a CTLV, we can set a hint whether this is a potentially =

'relocatable' CTLV, or this CTLV will always be of size less than 127 bytes.
- When we're done adding CTLVs, we can group our 'memmoves' of those CTLVs =

which are not relocatable.  For relocatable CTLVs we can set an initial fla=
g on =

the tag from the set of reserved tags, e.g. 00, FF, etc.
- In case the CTLV reaches maximum size, it becomes non-relocatable.
- The relocation of BER-TLV is not necessary as we can fill the tag and len=
gth =

information at an offset from the beginning such that the data will follow =

immediately afterwards.  We simply return the data starting at this offset.
- This should hopefully result in not having to use memmove in the most com=
mon =

case.

I hope that made sense :)

> +gboolean comprehension_tlv_constr_init(struct comprehension_tlv_constr
>  *constr, +					unsigned char *pdu, unsigned int size);
> +gboolean comprehension_tlv_constr_next(struct comprehension_tlv_constr
>  *constr); +gboolean comprehension_tlv_constr_set_tag(
> +					struct comprehension_tlv_constr *constr,
> +					gboolean cr, unsigned short tag);
> +gboolean comprehension_tlv_constr_set_length(
> +					struct comprehension_tlv_constr *constr,
> +					unsigned int len);
> +unsigned char *comprehension_tlv_constr_get_data(
> +				struct comprehension_tlv_constr *constr);
> +
>  void ber_tlv_iter_init(struct ber_tlv_iter *iter, const unsigned char
>  *pdu, unsigned int len);
>  /*
> @@ -164,6 +192,22 @@ void ber_tlv_iter_recurse_simple(struct ber_tlv_iter
>  *iter, void ber_tlv_iter_recurse_comprehension(struct ber_tlv_iter *iter,
>  struct comprehension_tlv_iter *recurse);
> =

> +gboolean ber_tlv_constr_init(struct ber_tlv_constr *constr,
> +				unsigned char *pdu, unsigned int size);
> +gboolean ber_tlv_constr_set_tag(struct ber_tlv_constr *constr,
> +				enum ber_tlv_data_type class,
> +				enum ber_tlv_data_encoding_type encoding,
> +				unsigned short tag);
> +gboolean ber_tlv_constr_set_length(struct ber_tlv_constr *constr,
> +					unsigned int len);
> +unsigned char *ber_tlv_constr_get_data(struct ber_tlv_constr *constr);
> +gboolean ber_tlv_constr_next(struct ber_tlv_constr *constr);
> +gboolean ber_tlv_constr_recurse(struct ber_tlv_constr *constr,
> +				struct ber_tlv_constr *recurse);
> +gboolean ber_tlv_constr_recurse_comprehension(struct ber_tlv_constr
>  *constr, +				struct comprehension_tlv_constr *recurse);
> +
> +
>  struct sim_eons *sim_eons_new(int pnn_records);
>  void sim_eons_add_pnn_record(struct sim_eons *eons, int record,
>  				const guint8 *tlv, int length);
> =


I think we should not try to make generic ber/ctlv encoding utilities, lets =

concentrate on doing the sim toolkit ones only.  This will allow us to make =

several simplifications (e.g. not worry about multi-byte ber-tlv tags, etc)

Something like:

stk_ber_tlv_builder_init(iter, tag);
stk_ber_tlv_builder_open_container(iter, container, tag);
stk_ber_tlv_builder_close_container(iter, container);
stk_ber_tlv_builder_optimize(iter);

stk_ctlv_append_byte(iter, byte);
stk_ctlv_append_short(iter, short);
stk_ctlv_append_data(iter, data, len);
stk_ctlv_append_text(iter, text) -> If we can make this work, converts to d=
cs, =

data format pair

Since Terminal Responses are not wrapped in BER-TLVs, we can simply invent =
a =

dummy value and return the data at offset starting at the first CTLV.

Comments?

Regards,
-Denis

--===============0231328701662941919==--

