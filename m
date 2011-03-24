Content-Type: multipart/mixed; boundary="===============5809280800538725279=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 5/6] stkutil: Complete the TLV parsing/builder to support
 BIP commands
Date: Thu, 24 Mar 2011 12:56:03 +0100
Message-ID: <4D8B3153.6050105@linux.intel.com>
In-Reply-To: <4D8A6596.5080203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5809280800538725279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/23/2011 10:26 PM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 03/22/2011 07:51 AM, Philippe Nunes wrote:
>> ---
>>   src/stkutil.c |  300 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++----
>>   src/stkutil.h |  141 +++++++++++++++++++++++----
>>   2 files changed, 402 insertions(+), 39 deletions(-)
>>
>> diff --git a/src/stkutil.c b/src/stkutil.c
>> index c64cb7a..b03dfb4 100644
>> --- a/src/stkutil.c
>> +++ b/src/stkutil.c
>> @@ -1264,8 +1264,22 @@ static gboolean parse_dataobj_bearer_description(
>>
>>   	data =3D comprehension_tlv_iter_get_data(iter);
>>   	bd->type =3D data[0];
>> -	bd->len =3D len - 1;
>> -	memcpy(bd->pars, data + 1, bd->len);
>> +
>> +	if (bd->type =3D=3D STK_BEARER_TYPE_GPRS_UTRAN) {
>> +		if (len<  7)
>> +			return FALSE;
>> +
>> +		bd->parameters.gprs.precedence =3D data[1];
>> +		bd->parameters.gprs.delay =3D data[2];
>> +		bd->parameters.gprs.reliability =3D data[3];
>> +		bd->parameters.gprs.peak =3D data[4];
>> +		bd->parameters.gprs.mean =3D data[5];
>> +		bd->parameters.gprs.pdp_type =3D data[6];
>
> Please do me a favor and insert an empty line here.  I like the blocks
> to be grouped logically, especially the bigger ones.
>
>> +		return TRUE;
>> +	}
>> +
>> +	bd->parameters.other.len =3D len - 1;
>> +	memcpy(bd->parameters.other.pars, data + 1, bd->parameters.other.len);
>>
>>   	return TRUE;
>>   }
>> @@ -1356,7 +1370,11 @@ static gboolean parse_dataobj_other_address(
>>
>>   	data =3D comprehension_tlv_iter_get_data(iter);
>>   	oa->type =3D data[0];
>> -	memcpy(&oa->addr, data + 1, len - 1);
>> +
>> +	if (oa->type =3D=3D STK_ADDRESS_IPV4)
>> +		memcpy(&oa->addr.ipv4, data + 1, 4);
>> +	else
>> +		memcpy(&oa->addr.ipv6, data + 1, 16);
>
> You might want to be more paranoid here, don't assume that just because
> oa->type !=3D STK_ADDRESS_IPV4 it will be IPv6.
>
>>
>>   	return TRUE;
>>   }
>> @@ -1604,16 +1622,33 @@ static gboolean parse_dataobj_esn(struct compreh=
ension_tlv_iter *iter,
>>   static gboolean parse_dataobj_network_access_name(
>>   		struct comprehension_tlv_iter *iter, void *user)
>>   {
>> -	struct stk_network_access_name *nan =3D user;
>> +	struct stk_network_access_name *apn =3D user;
>>   	const unsigned char *data;
>>   	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
>> +	size_t label_size;
>
> Why is unsigned char not sufficient?
>
>>
>> -	if (len =3D=3D 0)
>> +	if ((len =3D=3D 0) || (len>  100))
>
> Please don't do this, unnecessary parentheses are a distraction.  Learn
> the precedence of operators or do like I do it: use a cheat sheet.
>
>>   		return FALSE;
>>
>>   	data =3D comprehension_tlv_iter_get_data(iter);
>> -	nan->len =3D len;
>> -	memcpy(nan->name, data, len);
>> +	/*
>> +	 * As specified in TS 23 003 Section 9
>> +	 * The APN consists of one or more labels. Each label is coded as
>> +	 * a one octet length field followed by that number of octets coded
>> +	 * as 8 bit ASCII characters
>> +	 */
>> +
>> +	while (len) {
>> +		label_size =3D *data;
>> +		data++;
>> +		strncat((char *)apn->name, (char *)data, label_size);
>> +		data +=3D label_size;
>> +		len -=3D label_size + 1;
>> +		if (len)
>
> doc/coding-style.txt, item M1
>
>> +			strcat((char *)apn->name, ".");
>> +	}
>> +
>> +	apn->len =3D strlen((const char *)apn->name);
>
> Overall this code is pretty inefficient and not paranoid enough.
>
> For paranoidness: you need to be making sure that label_size is sane and
> not going to take you past your tlv length.
>
> For efficiency: use memcpy and direct assignment instead of strncat.
> While strncat is certainly fast, it still forces you to scan the entire
> dest string to find its length.
>
>>
>>   	return TRUE;
>>   }
>> @@ -3274,7 +3309,68 @@ static enum stk_command_parse_result parse_launch=
_browser(
>>   				STK_DATA_OBJECT_TYPE_INVALID);
>>   }
>>
>> -/* TODO: parse_open_channel */
>> +static void destroy_open_channel(struct stk_command *command)
>> +{
>> +	g_free(command->open_channel.alpha_id);
>> +	g_free(command->open_channel.text_usr);
>> +	g_free(command->open_channel.text_passwd);
>> +}
>> +
>> +static enum stk_command_parse_result parse_open_channel(
>> +					struct stk_command *command,
>> +					struct comprehension_tlv_iter *iter)
>> +{
>> +	struct stk_command_open_channel *obj =3D&command->open_channel;
>> +	enum stk_command_parse_result status;
>> +
>> +	if (command->qualifier>=3D 0x08)
>> +		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
>
> I know you're only parsing a particular type of Open Channel, but it
> might be a good idea to check this once that type has been determined.
>
>> +
>> +	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
>> +		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
>> +
>> +	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
>> +		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
>> +
>> +	command->destructor =3D destroy_open_channel;
>> +
>> +	/*
>> +	 * parse the Open Channel data objects related to packet data service
>> +	 * bearer
>> +	 */
>> +	status =3D parse_dataobj(iter,
>> +				STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
>> +				&obj->alpha_id,
>> +				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
>> +				&obj->icon_id,
>> +				STK_DATA_OBJECT_TYPE_BEARER_DESCRIPTION,
>> +				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
>> +				&obj->bearer_desc,
>> +				STK_DATA_OBJECT_TYPE_BUFFER_SIZE,
>> +				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
>> +				&obj->buf_size,
>> +				STK_DATA_OBJECT_TYPE_NETWORK_ACCESS_NAME, 0,
>> +				&obj->network_name,
>> +				STK_DATA_OBJECT_TYPE_OTHER_ADDRESS, 0,
>> +				&obj->local_addr,
>> +				STK_DATA_OBJECT_TYPE_TEXT, 0,
>> +				&obj->text_usr,
>> +				STK_DATA_OBJECT_TYPE_TEXT, 0,
>> +				&obj->text_passwd,
>> +				STK_DATA_OBJECT_TYPE_UICC_TE_INTERFACE, 0,
>> +				&obj->uti,
>> +				STK_DATA_OBJECT_TYPE_OTHER_ADDRESS, 0,
>> +				&obj->data_dest_addr,
>> +				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
>> +				&obj->text_attr,
>> +				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
>> +				&obj->frame_id,
>> +				STK_DATA_OBJECT_TYPE_INVALID);
>> +
>> +	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
>> +
>> +	return status;
>> +}
>>
>>   static void destroy_close_channel(struct stk_command *command)
>>   {
>> @@ -3291,7 +3387,8 @@ static enum stk_command_parse_result parse_close_c=
hannel(
>>   	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
>>   		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
>>
>> -	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
>> +	if ((command->dst<  STK_DEVICE_IDENTITY_TYPE_CHANNEL_1) ||
>> +		(command->dst>  STK_DEVICE_IDENTITY_TYPE_CHANNEL_7))
>
> doc/coding-style.txt item M4
>
>>   		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
>>
>>   	command->destructor =3D destroy_close_channel;
>> @@ -3353,7 +3450,7 @@ static enum stk_command_parse_result parse_receive=
_data(
>>   static void destroy_send_data(struct stk_command *command)
>>   {
>>   	g_free(command->send_data.alpha_id);
>> -	g_free(command->send_data.data.array);
>> +	g_free(command->send_data.tx_data.array);
>>   }
>>
>>   static enum stk_command_parse_result parse_send_data(
>> @@ -3363,6 +3460,9 @@ static enum stk_command_parse_result parse_send_da=
ta(
>>   	struct stk_command_send_data *obj =3D&command->send_data;
>>   	enum stk_command_parse_result status;
>>
>> +	if (command->qualifier>  STK_SEND_DATA_IMMEDIATELY)
>> +			return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
>> +
>>   	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
>>   		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
>>
>> @@ -3378,7 +3478,7 @@ static enum stk_command_parse_result parse_send_da=
ta(
>>   				&obj->icon_id,
>>   				STK_DATA_OBJECT_TYPE_CHANNEL_DATA,
>>   				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
>> -				&obj->data,
>> +				&obj->tx_data,
>
> tx_data is a bit redundant, since we're already in the send_data command.
>
>>   				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
>>   				&obj->text_attr,
>>   				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
>> @@ -3737,6 +3837,8 @@ static enum stk_command_parse_result parse_command=
_body(
>>   		return parse_language_notification(command, iter);
>>   	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
>>   		return parse_launch_browser(command, iter);
>> +	case STK_COMMAND_TYPE_OPEN_CHANNEL:
>> +		return parse_open_channel(command, iter);
>>   	case STK_COMMAND_TYPE_CLOSE_CHANNEL:
>>   		return parse_close_channel(command, iter);
>>   	case STK_COMMAND_TYPE_RECEIVE_DATA:
>> @@ -4755,9 +4857,41 @@ static gboolean build_dataobj_bearer_description(=
struct stk_tlv_builder *tlv,
>>   	if (bd->type =3D=3D 0x00)
>>   		return TRUE;
>>
>> +	if (bd->type =3D=3D STK_BEARER_TYPE_GPRS_UTRAN) {
>> +
>
> Please remove this empty line
>
>> +		return stk_tlv_builder_open_container(tlv, cr, tag, FALSE)&&
>> +		stk_tlv_builder_append_byte(tlv, bd->type)&&
>> +		stk_tlv_builder_append_byte(tlv,
>> +				bd->parameters.gprs.precedence)&&
>> +		stk_tlv_builder_append_byte(tlv,
>> +				bd->parameters.gprs.delay)&&
>> +		stk_tlv_builder_append_byte(tlv,
>> +				bd->parameters.gprs.reliability)&&
>> +		stk_tlv_builder_append_byte(tlv,
>> +				bd->parameters.gprs.peak)&&
>> +		stk_tlv_builder_append_byte(tlv,
>> +				bd->parameters.gprs.mean)&&
>> +		stk_tlv_builder_append_byte(tlv,
>> +				bd->parameters.gprs.pdp_type)&&
>> +		stk_tlv_builder_close_container(tlv);
>
> Please do me a favor and indent everything after the return at least one
> more level.  Use a separate function if you have to.
>
>> +	}
>> +
>>   	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE)&&
>>   		stk_tlv_builder_append_byte(tlv, bd->type)&&
>> -		stk_tlv_builder_append_bytes(tlv, bd->pars, bd->len)&&
>> +		stk_tlv_builder_append_bytes(tlv, bd->parameters.other.pars,
>> +				bd->parameters.other.len)&&
>> +		stk_tlv_builder_close_container(tlv);
>> +}
>> +
>> +/* Described in TS 102.223 Section 8.53 */
>> +static gboolean build_dataobj_channel_data(struct stk_tlv_builder *tlv,
>> +						const void *data, gboolean cr)
>> +{
>> +	const struct stk_common_byte_array *cd =3D data;
>> +	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CHANNEL_DATA;
>> +
>> +	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE)&&
>> +		stk_tlv_builder_append_bytes(tlv, cd->array, cd->len)&&
>>   		stk_tlv_builder_close_container(tlv);
>>   }
>>
>> @@ -4774,15 +4908,56 @@ static gboolean build_dataobj_channel_data_lengt=
h(
>>   		stk_tlv_builder_close_container(tlv);
>>   }
>>
>> +/* Described in TS 102.223 Section 8.55 */
>> +static gboolean build_dataobj_buffer_size(struct stk_tlv_builder *tlv,
>> +					const void *data, gboolean cr)
>> +{
>> +	const guint16 *buf_size =3D data;
>> +	unsigned char tag =3D STK_DATA_OBJECT_TYPE_BUFFER_SIZE;
>> +
>> +	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE)&&
>> +		stk_tlv_builder_append_short(tlv, *buf_size)&&
>> +		stk_tlv_builder_close_container(tlv);
>> +}
>> +
>>   /* Described in TS 102.223 Section 8.56 */
>>   static gboolean build_dataobj_channel_status(struct stk_tlv_builder *t=
lv,
>>   						const void *data, gboolean cr)
>>   {
>> +	const struct stk_channel *channel =3D data;
>>   	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CHANNEL_STATUS;
>> +	gboolean ok =3D FALSE;
>>
>> -	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE)&&
>> -		stk_tlv_builder_append_bytes(tlv, data, 2)&&
>> -		stk_tlv_builder_close_container(tlv);
>> +	if (stk_tlv_builder_open_container(tlv, cr, tag, FALSE) =3D=3D FALSE)
>> +			return FALSE;
>> +
>> +	switch (channel->status) {
>> +	case STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED:
>> +	case STK_CHANNEL_TCP_IN_CLOSED_STATE:
>> +		ok =3D stk_tlv_builder_append_byte(tlv, channel->id)&&
>> +			stk_tlv_builder_append_byte(tlv, 0x00);
>> +		break;
>> +	case STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED:
>> +	case STK_CHANNEL_TCP_IN_ESTABLISHED_STATE:
>> +		ok =3D stk_tlv_builder_append_byte(tlv,
>> +				channel->id | 0x80)&&
>> +			stk_tlv_builder_append_byte(tlv, 0x00);
>> +		break;
>> +	case STK_CHANNEL_TCP_IN_LISTEN_STATE:
>> +		ok =3D stk_tlv_builder_append_byte(tlv,
>> +			channel->id | 0x40)&&
>> +			stk_tlv_builder_append_byte(tlv, 0x00);
>> +		break;
>> +	case STK_CHANNEL_LINK_DROPPED:
>> +		ok =3D stk_tlv_builder_append_byte(tlv, channel->id)&&
>> +			stk_tlv_builder_append_byte(tlv, 0x05);
>> +		break;
>> +	}
>
> I'd rather you use a two byte array and fill the contents in the switch
> statement.  Then do the append_bytes after.
>
> e.g.
>
> switch(status)
> case foo:
> 	data[0] =3D ...
> 	data[1] =3D ...
> 	break;
> ...
> }
>
> if (!stk_tlv_builder_append_byte(data[0]) ||
> !stk_tlv_builder_append_byte(data[1])
> 	return FALSE;
>
>
>> +
>> +	if (!ok)
>> +		return FALSE;
>> +
>> +	return stk_tlv_builder_close_container(tlv);
>>   }
>>
>>   /* Described in TS 102.223 Section 8.58 */
>> @@ -4806,7 +4981,7 @@ static gboolean build_dataobj_other_address(struct=
 stk_tlv_builder *tlv,
>>   	case STK_ADDRESS_IPV4:
>>   		ok =3D stk_tlv_builder_append_byte(tlv, addr->type)&&
>>   			stk_tlv_builder_append_bytes(tlv,
>> -					(const guint8 *)&addr->addr.ipv4, 4);
>> +					(const guint8*)&addr->addr.ipv4, 4);
>
> Why? The original version is just fine
>
>>   		break;
>>   	case STK_ADDRESS_IPV6:
>>   		ok =3D stk_tlv_builder_append_byte(tlv, addr->type)&&
>> @@ -5159,7 +5334,7 @@ static gboolean build_dataobj_registry_application=
_data(
>>   	len =3D gsmlen;
>>   	dcs =3D 0x04;
>>   	if (name =3D=3D NULL) {
>> -		name =3D (guint8 *) g_convert((const gchar *) rad->name, -1,
>> +		name =3D (guint8 *) g_convert((const gchar*) rad->name, -1,
>
> And here
>
>>   						"UCS-2BE", "UTF-8//TRANSLIT",
>>   						NULL,&len, NULL);
>>   		dcs =3D 0x08;
>> @@ -5454,6 +5629,55 @@ static gboolean build_local_info(struct stk_tlv_b=
uilder *builder,
>>   	return FALSE;
>>   }
>>
>> +static gboolean build_open_channel(struct stk_tlv_builder *builder,
>> +					const struct stk_response *response)
>> +{
>> +	const struct stk_response_open_channel *open_channel =3D
>> +		&response->open_channel;
>> +
>> +	/* insert channel identifier only in case of success */
>> +	if (response->result.type =3D=3D STK_RESULT_TYPE_SUCCESS) {
>> +
>
> Please remove this empty line, this is covered in doc/coding-style.txt
> item M1.
>
>> +		if (build_dataobj(builder, build_dataobj_channel_status,
>> +						0,&open_channel->channel,
>> +						NULL) !=3D TRUE)
>> +			return FALSE;
>> +	}
>> +
>> +	return build_dataobj(builder,
>> +				build_dataobj_bearer_description,
>> +				0,&open_channel->bearer_desc,
>> +				build_dataobj_buffer_size,
>> +				0,&open_channel->buf_size,
>> +				NULL);
>> +}
>> +
>> +static gboolean build_receive_data(struct stk_tlv_builder *builder,
>> +					const struct stk_response *response)
>> +{
>> +	const struct stk_response_receive_data *receive_data =3D
>> +		&response->receive_data;
>> +
>> +	if (response->result.type =3D=3D STK_RESULT_TYPE_SUCCESS) {
>> +
>
> And again an unneeded empty line ;)
>
>> +		if (receive_data->rx_data.len) {
>> +			if (build_dataobj(builder, build_dataobj_channel_data,
>> +					DATAOBJ_FLAG_CR,
>> +					&response->receive_data.rx_data,
>> +					NULL) !=3D TRUE)
>> +				return FALSE;
>> +		}
>> +
>> +		return build_dataobj(builder,
>> +				build_dataobj_channel_data_length,
>> +				DATAOBJ_FLAG_CR,
>> +				&response->receive_data.data_left_length,
>> +				NULL);
>> +	}
>> +
>> +	return TRUE;
>> +}
>> +
>>   const unsigned char *stk_pdu_from_response(const struct stk_response *=
response,
>>   						unsigned int *out_length)
>>   {
>> @@ -5493,7 +5717,7 @@ const unsigned char *stk_pdu_from_response(const s=
truct stk_response *response,
>>   	 * Min =3D N.
>>   	 *
>>   	 * However comprehension required is set for many of the TLVs in
>> -	 * TS 102 384 conformace tests so we set it per command and per
>> +	 * TS 102 384 conformance tests so we set it per command and per
>
> This really belongs in a separate patch
>
>>   	* data object type.
>>   	 */
>>   	tag =3D STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES;
>> @@ -5582,6 +5806,7 @@ const unsigned char *stk_pdu_from_response(const s=
truct stk_response *response,
>>   	case STK_COMMAND_TYPE_SEND_DTMF:
>>   	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
>>   	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
>> +	case STK_COMMAND_TYPE_CLOSE_CHANNEL:
>>   		break;
>>   	case STK_COMMAND_TYPE_SEND_USSD:
>>   		ok =3D build_dataobj(&builder,
>> @@ -5590,6 +5815,39 @@ const unsigned char *stk_pdu_from_response(const =
struct stk_response *response,
>>   					&response->send_ussd.text,
>>   					NULL);
>>   		break;
>> +	case STK_COMMAND_TYPE_OPEN_CHANNEL:
>> +		/*
>> +		 * return the channel identifier and the channel status
>> +		 */
>> +		ok =3D build_open_channel(&builder, response);
>> +		break;
>> +	case STK_COMMAND_TYPE_RECEIVE_DATA:
>> +		/*
>> +		 * return the requested data and the number of bytes
>> +		 * remaining in the Rx buffer
>> +		 */
>> +		ok =3D build_receive_data(&builder, response);
>> +		break;
>
> I don't really see the point of these comments, especially here.
> Comments should not describe something that is obvious and should try to
> be local to where they are relevant.  If I peek inside
> build_receive_data then this comment is really redundant.
>
>> +	case STK_COMMAND_TYPE_SEND_DATA:
>> +		/*
>> +		 * return the number of bytes of empty space available
>> +		 * in the Tx buffer
>> +		 */
>> +		if (response->result.type =3D=3D STK_RESULT_TYPE_SUCCESS) {
>> +			ok =3D build_dataobj(&builder,
>> +					build_dataobj_channel_data_length,
>> +					DATAOBJ_FLAG_CR,
>> +					&response->send_data.empty_data_length,
>> +					NULL);
>> +		}
>> +		break;
>
> I suggest you use a dedicated function for builders that include objects
> conditionally.
>
>> +	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
>> +		ok =3D build_dataobj(&builder,
>> +					build_dataobj_channel_status,
>> +					DATAOBJ_FLAG_CR,
>> +					&response->channel_status.channel,
>> +					NULL);
>> +		break;
>>   	default:
>>   		return NULL;
>>   	};
>> @@ -5738,7 +5996,7 @@ static gboolean build_envelope_event_download(stru=
ct stk_tlv_builder *builder,
>>   		return build_dataobj(builder,
>>   					build_dataobj_channel_status,
>>   					DATAOBJ_FLAG_CR,
>> -					&evt->data_available.channel_status,
>> +					&evt->data_available.channel,
>>   					build_dataobj_channel_data_length,
>>   					DATAOBJ_FLAG_CR,
>>   					&evt->data_available.channel_data_len,
>> @@ -5747,7 +6005,7 @@ static gboolean build_envelope_event_download(stru=
ct stk_tlv_builder *builder,
>>   		return build_dataobj(builder,
>>   					build_dataobj_channel_status,
>>   					DATAOBJ_FLAG_CR,
>> -					&evt->channel_status.status,
>> +					&evt->channel_status.channel,
>>   					build_dataobj_bearer_description,
>>   					DATAOBJ_FLAG_CR,
>>   					&evt->channel_status.bearer_desc,
>> @@ -6269,7 +6527,7 @@ char *stk_image_to_xpm(const unsigned char *img, u=
nsigned int len,
>>
>>   	/*
>>   	 * space needed:
>> -	 * 	header line
>> +	 *	header line
>
> Again, belongs in a separate cleanup patch
>
>>   	*	declaration and beginning of assignment line
>>   	 *	values - max length of 19
>>   	 *	colors - ncolors * (cpp + whitespace + deliminators + color)
>> diff --git a/src/stkutil.h b/src/stkutil.h
>> index f2df23f..241a807 100644
>> --- a/src/stkutil.h
>> +++ b/src/stkutil.h
>> @@ -245,7 +245,7 @@ enum stk_result_type {
>>   	STK_RESULT_TYPE_USER_REJECT =3D			0x22,
>>   	STK_RESULT_TYPE_USER_CANCEL =3D			0x23,
>>   	STK_RESULT_TYPE_TIMER_CONFLICT =3D		0x24,
>> -	STK_RESULT_TYPE_CALL_CONTROL_TEMPORARY =3D 	0x25,
>> +	STK_RESULT_TYPE_CALL_CONTROL_TEMPORARY =3D	0x25,
>
> Separate cleanup patch please
>
>>   	STK_RESULT_TYPE_BROWSER_TEMPORARY =3D		0x26,
>>   	STK_RESULT_TYPE_MMS_TEMPORARY =3D			0x27,
>>
>> @@ -426,13 +426,17 @@ enum stk_browser_termination_cause {
>>   };
>>
>>   enum stk_bearer_type {
>
> Can you do me a favor and add the Section # for the enums / structs
> you're modifying / introducing where needed.  We were supposed to be
> doing this but somehow were not consistent enough over time.
>
>> +	STK_BEARER_TYPE_CS =3D			0x01,
>> +	STK_BEARER_TYPE_GPRS_UTRAN =3D		0x02,
>>   	STK_BEARER_TYPE_DEFAULT =3D		0x03,
>>   	STK_BEARER_TYPE_INDEPENDENT =3D		0x04,
>>   	STK_BEARER_TYPE_BLUETOOTH =3D		0x05,
>>   	STK_BEARER_TYPE_IRDA =3D			0x06,
>>   	STK_BEARER_TYPE_RS232 =3D			0x07,
>> -	STK_BEARER_TYPE_PACKET_DATA_SERVICE =3D	0x08,
>> -	STK_BEARER_TYPE_I_WLAN =3D		0x0a,
>> +	STK_BEARER_TYPE_TIA_EIA_IS_820 =3D	0x08,
>> +	STK_BEARER_TYPE_UTRAN_WITH_EXT_PARAMS =3D 0x09,
>> +	STK_BEARER_TYPE_I_WLAN =3D		0x0A,
>> +	STK_BEARER_TYPE_EUTRAN_MAPPED_UTRAN =3D	0x0B,
>>   	STK_BEARER_TYPE_USB =3D			0x10
>>   };
>>
>> @@ -587,6 +591,36 @@ enum stk_img_scheme {
>>   	STK_IMG_SCHEME_TRANSPARENCY =3D	0x22,
>>   };
>>
>> +enum stk_transport_protocol_type {
>> +	STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE =3D	0x01,
>> +	STK_TRANSPORT_PROTOCOL_TCP_CLIENT_REMOTE =3D	0x02,
>> +	STK_TRANSPORT_PROTOCOL_TCP_SERVER =3D		0x03,
>> +	STK_TRANSPORT_PROTOCOL_UDP_CLIENT_LOCAL =3D	0x04,
>> +	STK_TRANSPORT_PROTOCOL_TCP_CLIENT_LOCAL =3D	0x05,
>> +	STK_TRANSPORT_PROTOCOL_DIRECT =3D			0x06,
>> +};
>> +
>> +enum stk_channel_status {
>> +	STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED =3D 0x00,
>> +	STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED =3D	0x01,
>> +	STK_CHANNEL_TCP_IN_CLOSED_STATE =3D		0x02,
>> +	STK_CHANNEL_TCP_IN_LISTEN_STATE =3D		0x03,
>> +	STK_CHANNEL_TCP_IN_ESTABLISHED_STATE =3D		0x04,
>> +	STK_CHANNEL_LINK_DROPPED =3D			0x05,
>> +};
>> +
>> +enum stk_qualifier_open_channel {
>> +	STK_OPEN_CHANNEL_ON_DEMAND =3D			0x00,
>> +	STK_OPEN_CHANNEL_IMMEDIATE =3D			0x01,
>> +	STK_OPEN_CHANNEL_AUTOMATIC_RECONNECTION =3D	0x02,
>> +	STK_OPEN_CHANNEL_IMMEDIATE_IN_BACKGROUND_MODE =3D	0x04,
>> +};
>> +
>> +enum stk_qualifier_send_data {
>> +	STK_SEND_DATA_STORE_DATA =3D	0x00,
>> +	STK_SEND_DATA_IMMEDIATELY =3D	0x01,
>> +};
>> +
>>   /* For data object that only has a byte array with undetermined length=
 */
>>   struct stk_common_byte_array {
>>   	unsigned char *array;
>> @@ -849,18 +883,31 @@ struct stk_timing_advance {
>>   	unsigned char advance;
>>   };
>>
>> -/*
>> - * According to 102.223 Section 8.52 the length of CTLV is 1 byte. This=
 means
>> - * that the maximum size is 127 according to the rules of CTLVs. This s=
ize also
>> - * includes bearer type for 1 byte, so the maxmimum size of bearer para=
meters
>> - * is 126.
>> - */
>> -struct stk_bearer_description {
>> -	unsigned char type;
>> +/* Bearer parameters for GPRS/UTRAN Packet Service/E-UTRAN */
>> +struct stk_gprs_bearer_parameters {
>> +	unsigned char precedence;
>> +	unsigned char delay;
>> +	unsigned char reliability;
>> +	unsigned char peak;
>> +	unsigned char mean;
>> +	unsigned char pdp_type;
>> +};
>> +
>> +/* Generic bearer parameters */
>> +struct stk_other_bearer_parameters {
>>   	unsigned char pars[126];
>>   	unsigned int len;
>>   };
>>
>> +/* Defined in TS 31.111 Section 8.52 */
>> +struct stk_bearer_description {
>> +	enum stk_bearer_type type;
>> +	union {
>> +		struct stk_gprs_bearer_parameters gprs;
>> +		struct stk_other_bearer_parameters other;
>> +	} parameters;
>
> You can use an un-named union here and refer to the structures a bit
> easier.  e.g. bs->gprs or bs->other.
>
>> +};
>> +
>>   /*
>>    * According to 102.223 Section 8.57 the length of CTLV is 1 byte. Thi=
s means
>>    * that the maximum size is 127 according to the rules of CTLVs.
>> @@ -885,7 +932,7 @@ struct stk_other_address {
>>
>>   /* Defined in TS 102.223 Section 8.59 */
>>   struct stk_uicc_te_interface {
>> -	unsigned char protocol;
>> +	enum stk_transport_protocol_type protocol;
>>   	unsigned short port;
>>   };
>>
>> @@ -950,11 +997,12 @@ struct stk_remote_entity_address {
>>   };
>>
>>   /*
>> - * According to 102.223 Section 8.70 the length of CTLV is 1 byte. This=
 means
>> - * that the maximum size is 127 according to the rules of CTLVs.
>> + * According to 102.223 Section 8.70 the length of CTLV is 1 byte.
>> + * According to the 23.003 Section 9.0, the APN has, after encoding,
>> + * a maximum length of 100 octets
>>    */
>>   struct stk_network_access_name {
>> -	unsigned char name[127];
>> +	unsigned char name[100];
>>   	unsigned char len;
>
> This part really makes no sense.  Since you parse it into a string,
> might as well just use that.

All the above comments are just relevant. Thank you for having spent =

time to point all these remarks and especially all the coding style =

noncompliances. I will apply your comments in a new patch and separate =

cleaning/typo modifications in another dedicated patch.

Here, the apn string is indeed extracted from the encoded buffer.
As the encoded apn just can't exceeed 100 bytes as per the spec and as =

the extracted string is lesser than 100 bytes since we are removing the =

octet length field , I considered that the string buffer was better =

sized with 100 bytes than 127. But perhaps, I'm over thinking here...

>
>>   };
>>
>> @@ -1250,6 +1298,21 @@ struct stk_command_launch_browser {
>>   	char *text_passwd;
>>   };
>>
>> +struct stk_command_open_channel {
>> +	char *alpha_id;
>> +	struct stk_icon_id icon_id;
>> +	struct stk_bearer_description bearer_desc;
>> +	unsigned short buf_size;
>> +	struct stk_network_access_name network_name;
>
> E.g. char *network_name;
>
>> +	struct stk_other_address local_addr;
>> +	char *text_usr;
>> +	char *text_passwd;
>> +	struct stk_uicc_te_interface uti;
>> +	struct stk_other_address data_dest_addr;
>> +	struct stk_text_attribute text_attr;
>> +	struct stk_frame_id frame_id;
>> +};
>> +
>>   struct stk_command_close_channel {
>>   	char *alpha_id;
>>   	struct stk_icon_id icon_id;
>> @@ -1268,7 +1331,7 @@ struct stk_command_receive_data {
>>   struct stk_command_send_data {
>>   	char *alpha_id;
>>   	struct stk_icon_id icon_id;
>> -	struct stk_common_byte_array data;
>> +	struct stk_common_byte_array tx_data;
>
> As I mentioned previously, I feel this is a bit redundant.
>
>>   	struct stk_text_attribute text_attr;
>>   	struct stk_frame_id frame_id;
>>   };
>> @@ -1368,6 +1431,7 @@ struct stk_command {
>>   		struct stk_command_send_dtmf send_dtmf;
>>   		struct stk_command_language_notification language_notification;
>>   		struct stk_command_launch_browser launch_browser;
>> +		struct stk_command_open_channel open_channel;
>>   		struct stk_command_close_channel close_channel;
>>   		struct stk_command_receive_data receive_data;
>>   		struct stk_command_send_data send_data;
>> @@ -1406,6 +1470,24 @@ struct stk_ussd_text {
>>   	int len;
>>   };
>>
>> +struct stk_channel {
>> +	unsigned char id;
>> +	enum stk_channel_status status;
>> +};
>> +
>> +struct stk_channel_data {
>> +	struct stk_common_byte_array data;
>> +	union{
>
> Forgot a space after union
>
>> +		/* The number of bytes remaining in the Rx buffer */
>> +		unsigned int data_left_length;
>
> So maybe rx_remaining is a better name?
>
>> +		/*
>> +		 * The number of bytes of empty space available
>> +		 * in the Tx buffer
>> +		 */
>> +		unsigned int empty_data_length;
>
> And tx_avail here?
>
> Then you don't need the comments ;)
>
> Also, why do you use unsigned int instead of unsigned char?
>

In practice, the size (rx_remaining or tx_avail) can reach 65535 as the =

buffer size it self given by the UICC is encoded by 2 bytes. I could =

consider indeed to use at least an unsigned short, but to be homogeneous =

with the type of the buffer size given by data.len, I preferred to go =

with an unsigned int.

>> +	};
>> +};
>> +
>>   struct stk_response_get_inkey {
>>   	struct stk_answer_text text;
>>   	struct stk_duration duration;
>> @@ -1481,6 +1563,25 @@ struct stk_response_send_ussd {
>>   	struct stk_ussd_text text;
>>   };
>>
>> +struct stk_response_open_channel {
>> +	struct stk_channel channel;
>> +	struct stk_bearer_description bearer_desc;
>> +	unsigned short buf_size;
>> +};
>> +
>> +struct stk_response_receive_data {
>> +	struct stk_common_byte_array rx_data;
>> +	unsigned char data_left_length;
>> +};
>> +
>> +struct stk_response_send_data {
>> +	unsigned char empty_data_length;
>> +};
>> +
>> +struct stk_response_channel_status {
>> +	struct stk_channel channel;
>> +};
>> +
>>   struct stk_response {
>>   	unsigned char number;
>>   	unsigned char type;
>> @@ -1511,6 +1612,10 @@ struct stk_response {
>>   		struct stk_response_generic language_notification;
>>   		struct stk_response_generic launch_browser;
>>   		struct stk_response_send_ussd send_ussd;
>> +		struct stk_response_open_channel open_channel;
>> +		struct stk_response_receive_data receive_data;
>> +		struct stk_response_send_data send_data;
>> +		struct stk_response_channel_status channel_status;
>>   	};
>>
>>   	void (*destructor)(struct stk_response *response);
>> @@ -1596,11 +1701,11 @@ struct stk_envelope_event_download {
>>   			enum stk_browser_termination_cause cause;
>>   		} browser_termination;
>>   		struct {
>> -			unsigned char channel_status[2];
>> +			struct stk_channel channel;
>>   			unsigned int channel_data_len;
>>   		} data_available;
>>   		struct {
>> -			unsigned char status[2];
>> +			struct stk_channel channel;
>>   			struct stk_bearer_description bearer_desc;
>>   			struct stk_other_address address;
>>   		} channel_status;
>
> Regards,
> -Denis
>


--===============5809280800538725279==--

