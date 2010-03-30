Content-Type: multipart/mixed; boundary="===============1549388185475403539=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 01/10] Add parser for items next action indicator
 objects
Date: Tue, 30 Mar 2010 10:28:46 -0500
Message-ID: <201003301028.46334.denkenz@gmail.com>
In-Reply-To: <1269935857-4234-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1549388185475403539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> +/* For data object that only has a byte array with variable length */
> +static gboolean parse_dataobj_common_byte_array(
> +			struct comprehension_tlv_iter *iter,
> +			enum stk_data_object_type type,
> +			unsigned char *array, unsigned int *array_len)
> +{
> +	const unsigned char *data;
> +	unsigned int len;
> +
> +	if (comprehension_tlv_iter_get_tag(iter) !=3D type)
> +		return FALSE;
> +
> +	len =3D comprehension_tlv_iter_get_length(iter);
> +	if (len < 1)
> +		return FALSE;
> +
> +	data =3D comprehension_tlv_iter_get_data(iter);
> +	*array_len =3D len;
> +	memcpy(array, data, len);
> +
> +	return TRUE;
> +}
> +

So I can see the point of this function for a byte array that requires to b=
e =

allocated.  For fixed size arrays this function is not adequate; it does no=
t do =

length (boundary) checking for instance.

Regards,
-Denis

--===============1549388185475403539==--

