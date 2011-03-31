Content-Type: multipart/mixed; boundary="===============0871397904422467986=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH v2 1/2] stkutil: Complete the TLV parsing/builder to
 support BIP commands
Date: Thu, 31 Mar 2011 12:37:31 +0200
Message-ID: <4D94596B.8070008@linux.intel.com>
In-Reply-To: <4D93D860.1030407@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0871397904422467986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/31/2011 03:26 AM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 03/30/2011 04:41 PM, Philippe Nunes wrote:
>> ---
>>   src/stkutil.c |  287 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++---
>>   src/stkutil.h |  132 ++++++++++++++++++++++-----
>>   2 files changed, 380 insertions(+), 39 deletions(-)
>
> <snip>
>
>>
>> @@ -1604,16 +1624,48 @@ static gboolean parse_dataobj_esn(struct compreh=
ension_tlv_iter *iter,
>>   static gboolean parse_dataobj_network_access_name(
>>   		struct comprehension_tlv_iter *iter, void *user)
>>   {
>> -	struct stk_network_access_name *nan =3D user;
>> +	char **apn =3D user;
>>   	const unsigned char *data;
>>   	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
>> +	unsigned char label_size;
>> +	unsigned char offset =3D 0;
>> +	char decoded_apn[100];
>>
>> -	if (len =3D=3D 0)
>> +	if (len =3D=3D 0 || len>  100)
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
>> +
>> +		if (label_size>  (len-1))
>> +			return FALSE;
>> +
>> +		memcpy(decoded_apn + offset, data + 1, label_size);
>> +
>> +		data +=3D label_size + 1;
>> +		offset +=3D label_size;
>> +
>> +		len -=3D label_size + 1;
>
> This really belongs with the data/offset increments
>
>> +		if (len) {
>> +			decoded_apn[offset] =3D '.';
>> +			offset +=3D 1;
>
> This might be better written as:
>
> if (len>  0)
> 	decoded_apn[offset++] =3D '.';
>
>> +		}
>> +	}
>> +
>> +	*apn =3D g_try_malloc(offset + 1);
>> +	if (*apn =3D=3D NULL)
>> +		return FALSE;
>> +
>> +	memcpy(*apn, decoded_apn, offset);
>> +	(*apn)[offset] =3D '\0';
>
> *apn =3D g_strdup(decoded_apn);
>
> is really just fine ;)
>
>>

Ok, I'm just going to use g_strndup to get the string null terminated.


>>   	return TRUE;
>>   }
>> @@ -3274,7 +3326,68 @@ static enum stk_command_parse_result parse_launch=
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
>
> =3D=3D9744=3D=3D 40 bytes in 4 blocks are definitely lost in loss record =
1,825
> of 1,925
> =3D=3D9744=3D=3D    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
> =3D=3D9744=3D=3D    by 0x41B868: parse_dataobj_network_access_name (stkut=
il.c:1663)
> =3D=3D9744=3D=3D    by 0x41AF95: parse_dataobj (stkutil.c:2415)
> =3D=3D9744=3D=3D    by 0x41CC1B: stk_command_new_from_pdu (stkutil.c:3358)
> =3D=3D9744=3D=3D    by 0x40A953: test_open_channel (test-stkutil.c:17257)
> =3D=3D9744=3D=3D    by 0x4E922E2: g_test_run_suite_internal (gtestutils.c=
:1138)
> =3D=3D9744=3D=3D    by 0x4E92455: g_test_run_suite_internal (gtestutils.c=
:1197)
> =3D=3D9744=3D=3D    by 0x4E9273A: g_test_run_suite (gtestutils.c:1246)
> =3D=3D9744=3D=3D    by 0x406C45: main (test-stkutil.c:26130)
>


Right, I missed to free the apn string.



> <snip>
>
>> +static gboolean build_receive_data(struct stk_tlv_builder *builder,
>> +					const struct stk_response *response)
>> +{
>> +	const struct stk_response_receive_data *receive_data =3D
>> +		&response->receive_data;
>> +
>> +	if (response->result.type =3D=3D STK_RESULT_TYPE_SUCCESS) {
>> +		if (receive_data->rx_data.len) {
>> +			if (build_dataobj(builder, build_dataobj_channel_data,
>> +					DATAOBJ_FLAG_CR,
>> +					&response->receive_data.rx_data,
>> +					NULL) !=3D TRUE)
>> +				return FALSE;
>> +		}
>> +
>> +		return build_dataobj(builder,
>> +					build_dataobj_channel_data_length,
>> +					DATAOBJ_FLAG_CR,
>> +					&response->receive_data.rx_remaining,
>> +					NULL);
>> +	}
>
> Avoid nesting whenever possible.  This really might be better written lik=
e:
>
> if (response->result.type !=3D STK_RESULT_TYPE_SUCCESS)
> 	return TRUE;
>
> if (...) {
> }
>
> return build_dataobj(...)
>
>> +
>> +	return TRUE;
>> +}
>> +
>> +static gboolean build_send_data(struct stk_tlv_builder *builder,
>> +					const struct stk_response *response)
>> +{
>> +	if (response->result.type =3D=3D STK_RESULT_TYPE_SUCCESS) {
>> +		return build_dataobj(builder,
>> +					build_dataobj_channel_data_length,
>> +					DATAOBJ_FLAG_CR,
>> +					&response->send_data.tx_avail,
>> +					NULL);
>> +	}
>> +
>
> Same comment as above
>

Ok, I try to keep this rule in mind.


>> +	return TRUE;
>> +}
>> +
>>   const unsigned char *stk_pdu_from_response(const struct stk_response *=
response,
>>   						unsigned int *out_length)
>>   {
>> +/* Defined in TS 102.223 Section 8.1 */
>
> ^^^
>
> This really doesn't sounds right for the Section
>

Yes, corrected to section 8.6 (command qualifier)

>> +enum stk_qualifier_send_data {
>> +	STK_SEND_DATA_STORE_DATA =3D	0x00,
>> +	STK_SEND_DATA_IMMEDIATELY =3D	0x01,
>> +};
>> +
>> +/* Defined in TS 102.223 Section 8.56 */
>> +enum stk_channel_status {
>> +	STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED =3D 0x00,
>> +	STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED =3D	0x01,
>> +	STK_CHANNEL_TCP_IN_CLOSED_STATE =3D		0x02,
>> +	STK_CHANNEL_TCP_IN_LISTEN_STATE =3D		0x03,
>> +	STK_CHANNEL_TCP_IN_ESTABLISHED_STATE =3D		0x04,
>> +	STK_CHANNEL_LINK_DROPPED =3D			0x05,
>> +};
>> +
>
> You're playing serious magic here, but fair enough.


Here, I'm introducing these enums to list only the different channel =

status but they can't be used indeed as direct values for the channel =

status TLV parsing/building.

Note that for the section:

enum stk_qualifier_open_channel {
	STK_OPEN_CHANNEL_ON_DEMAND =3D			0x00,
	STK_OPEN_CHANNEL_IMMEDIATE =3D			0x01,
	STK_OPEN_CHANNEL_AUTOMATIC_RECONNECTION =3D	0x02,
	STK_OPEN_CHANNEL_IMMEDIATE_IN_BACKGROUND_MODE =3D	0x04,
};

The purpose of these enums is to use them as bit masks. Maybe #defines =

could be more appropriate?

Regards,

Philippe.


--===============0871397904422467986==--

