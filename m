Content-Type: multipart/mixed; boundary="===============4451564886721853895=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] stkutil: Complete the TLV parsing/builder to
 support BIP commands
Date: Wed, 30 Mar 2011 20:26:56 -0500
Message-ID: <4D93D860.1030407@gmail.com>
In-Reply-To: <1301521287-12212-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4451564886721853895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 03/30/2011 04:41 PM, Philippe Nunes wrote:
> ---
>  src/stkutil.c |  287 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++---
>  src/stkutil.h |  132 ++++++++++++++++++++++-----
>  2 files changed, 380 insertions(+), 39 deletions(-)

<snip>

> =

> @@ -1604,16 +1624,48 @@ static gboolean parse_dataobj_esn(struct comprehe=
nsion_tlv_iter *iter,
>  static gboolean parse_dataobj_network_access_name(
>  		struct comprehension_tlv_iter *iter, void *user)
>  {
> -	struct stk_network_access_name *nan =3D user;
> +	char **apn =3D user;
>  	const unsigned char *data;
>  	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
> +	unsigned char label_size;
> +	unsigned char offset =3D 0;
> +	char decoded_apn[100];
>  =

> -	if (len =3D=3D 0)
> +	if (len =3D=3D 0 || len > 100)
>  		return FALSE;
>  =

>  	data =3D comprehension_tlv_iter_get_data(iter);
> -	nan->len =3D len;
> -	memcpy(nan->name, data, len);
> +	/*
> +	 * As specified in TS 23 003 Section 9
> +	 * The APN consists of one or more labels. Each label is coded as
> +	 * a one octet length field followed by that number of octets coded
> +	 * as 8 bit ASCII characters
> +	 */
> +
> +	while (len) {
> +		label_size =3D *data;
> +
> +		if (label_size > (len-1))
> +			return FALSE;
> +
> +		memcpy(decoded_apn + offset, data + 1, label_size);
> +
> +		data +=3D label_size + 1;
> +		offset +=3D label_size;
> +
> +		len -=3D label_size + 1;

This really belongs with the data/offset increments

> +		if (len) {
> +			decoded_apn[offset] =3D '.';
> +			offset +=3D 1;

This might be better written as:

if (len > 0)
	decoded_apn[offset++] =3D '.';

> +		}
> +	}
> +
> +	*apn =3D g_try_malloc(offset + 1);
> +	if (*apn =3D=3D NULL)
> +		return FALSE;
> +
> +	memcpy(*apn, decoded_apn, offset);
> +	(*apn)[offset] =3D '\0';

*apn =3D g_strdup(decoded_apn);

is really just fine ;)

>  =

>  	return TRUE;
>  }
> @@ -3274,7 +3326,68 @@ static enum stk_command_parse_result parse_launch_=
browser(
>  				STK_DATA_OBJECT_TYPE_INVALID);
>  }
>  =

> -/* TODO: parse_open_channel */
> +static void destroy_open_channel(struct stk_command *command)
> +{
> +	g_free(command->open_channel.alpha_id);
> +	g_free(command->open_channel.text_usr);
> +	g_free(command->open_channel.text_passwd);
> +}

=3D=3D9744=3D=3D 40 bytes in 4 blocks are definitely lost in loss record 1,=
825
of 1,925
=3D=3D9744=3D=3D    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
=3D=3D9744=3D=3D    by 0x41B868: parse_dataobj_network_access_name (stkutil=
.c:1663)
=3D=3D9744=3D=3D    by 0x41AF95: parse_dataobj (stkutil.c:2415)
=3D=3D9744=3D=3D    by 0x41CC1B: stk_command_new_from_pdu (stkutil.c:3358)
=3D=3D9744=3D=3D    by 0x40A953: test_open_channel (test-stkutil.c:17257)
=3D=3D9744=3D=3D    by 0x4E922E2: g_test_run_suite_internal (gtestutils.c:1=
138)
=3D=3D9744=3D=3D    by 0x4E92455: g_test_run_suite_internal (gtestutils.c:1=
197)
=3D=3D9744=3D=3D    by 0x4E9273A: g_test_run_suite (gtestutils.c:1246)
=3D=3D9744=3D=3D    by 0x406C45: main (test-stkutil.c:26130)

<snip>

> +static gboolean build_receive_data(struct stk_tlv_builder *builder,
> +					const struct stk_response *response)
> +{
> +	const struct stk_response_receive_data *receive_data =3D
> +		&response->receive_data;
> +
> +	if (response->result.type =3D=3D STK_RESULT_TYPE_SUCCESS) {
> +		if (receive_data->rx_data.len) {
> +			if (build_dataobj(builder, build_dataobj_channel_data,
> +					DATAOBJ_FLAG_CR,
> +					&response->receive_data.rx_data,
> +					NULL) !=3D TRUE)
> +				return FALSE;
> +		}
> +
> +		return build_dataobj(builder,
> +					build_dataobj_channel_data_length,
> +					DATAOBJ_FLAG_CR,
> +					&response->receive_data.rx_remaining,
> +					NULL);
> +	}

Avoid nesting whenever possible.  This really might be better written like:

if (response->result.type !=3D STK_RESULT_TYPE_SUCCESS)
	return TRUE;

if (...) {
}

return build_dataobj(...)

> +
> +	return TRUE;
> +}
> +
> +static gboolean build_send_data(struct stk_tlv_builder *builder,
> +					const struct stk_response *response)
> +{
> +	if (response->result.type =3D=3D STK_RESULT_TYPE_SUCCESS) {
> +		return build_dataobj(builder,
> +					build_dataobj_channel_data_length,
> +					DATAOBJ_FLAG_CR,
> +					&response->send_data.tx_avail,
> +					NULL);
> +	}
> +

Same comment as above

> +	return TRUE;
> +}
> +
>  const unsigned char *stk_pdu_from_response(const struct stk_response *re=
sponse,
>  						unsigned int *out_length)
>  {
> +/* Defined in TS 102.223 Section 8.1 */

^^^

This really doesn't sounds right for the Section

> +enum stk_qualifier_send_data {
> +	STK_SEND_DATA_STORE_DATA =3D	0x00,
> +	STK_SEND_DATA_IMMEDIATELY =3D	0x01,
> +};
> +
> +/* Defined in TS 102.223 Section 8.56 */
> +enum stk_channel_status {
> +	STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED =3D 0x00,
> +	STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED =3D	0x01,
> +	STK_CHANNEL_TCP_IN_CLOSED_STATE =3D		0x02,
> +	STK_CHANNEL_TCP_IN_LISTEN_STATE =3D		0x03,
> +	STK_CHANNEL_TCP_IN_ESTABLISHED_STATE =3D		0x04,
> +	STK_CHANNEL_LINK_DROPPED =3D			0x05,
> +};
> +

You're playing serious magic here, but fair enough.

Regards,
-Denis

--===============4451564886721853895==--

