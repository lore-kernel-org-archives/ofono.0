Content-Type: multipart/mixed; boundary="===============1680420860960237706=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: Re: [PATCH 3/3] gprs.c: add list contexts for emulator
Date: Tue, 22 Mar 2011 11:49:07 +0100
Message-ID: <4D887EA3.9060000@linux.intel.com>
In-Reply-To: <4D880431.6050309@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1680420860960237706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks Denis for your feedback.
The idea behind this code is to propose the complete support of the =

usual AT+CGDCONT in the emulator. I think the best solution might be to =

stick on contexts exposed over DBus, but this could lead to problems =

like : a context is delete throught the DBus interface... how to handle =

this change in the AT emulator, and avoid the use of the deleted context ?
Olivier





On 03/22/2011 03:06 AM, Denis Kenzior wrote:
> Hi Olivier,
>
> On 03/21/2011 08:45 AM, Olivier Guiter wrote:
>> ---
>>   src/gprs.c |   26 ++++++++++++++++++++++++--
>>   1 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/gprs.c b/src/gprs.c
>> index 04432c3..06d52f3 100644
>> --- a/src/gprs.c
>> +++ b/src/gprs.c
>> @@ -2863,11 +2863,31 @@ static void provision_contexts(struct ofono_gprs=
 *gprs, const char *mcc,
>>   	__ofono_gprs_provision_free_settings(settings, count);
>>   }
>>
>> +static void ofono_gprs_list_contexts(struct ofono_emulator *em, void *u=
serdata)
>> +{
>> +	struct ofono_gprs *gprs =3D userdata;
>> +	GSList *l;
>> +	char buf[256];
>> +
>> +	struct pri_context *ctx;
>> +
>> +	for (l =3D gprs->contexts; l; l =3D l->next) {
>> +		ctx =3D l->data;
>> +
>> +		snprintf(buf, 255, "+CGDCONT: %d,\"%s\",\"%s\"",
>> +				ctx->id, gprs_proto_to_string(ctx->context.proto),
>> +				ctx->context.apn);
> So you're mixing concepts here a bit.
>
> gprs.c has two maps:
>
> - pid_map
> - cid_map
>
> and two ids:
> - pri_context::id
> - ofono_gprs_primary_context::cid
>
> Roughly speaking the cid_map lets us pick a context id that maps 1:1 to
> the modem driver.  Hence the use of ofono_gprs_set_cid_range.  Basically
> the driver tells us the valid range of context ids and oFono picks the
> rest.  For an AT modem the driver can simply use the cid picked by oFono
> in activate_primary callback.
>
> Internally oFono has another idmap for tracking unique ids for contexts
> and ensuring some sane limit on their number.  This is managed by
> pid_map and pri_context::id.
>
> The code you have right now would use the pid_map ids...
>
>> +		ofono_emulator_send_info(em, buf, FALSE);
>> +	}
>> +}
>> +
>>   /* Process the usual AT+CGDCONT command
>>    */
>>   static void cgdcont_cb(struct ofono_emulator *em,
>>   			struct ofono_emulator_request *req, void *userdata)
>>   {
>> +	struct ofono_gprs *gprs =3D userdata;
>> +	struct idmap *cid =3D gprs->cid_map;
>>   	struct ofono_error result;
>>   	char buf[256];
>>
>> @@ -2876,7 +2896,8 @@ static void cgdcont_cb(struct ofono_emulator *em,
>>   	switch (ofono_emulator_request_get_type(req)) {
>>   	case OFONO_EMULATOR_REQUEST_TYPE_SUPPORT:
>>   		/* TODO: check additionnal parameters */
>> -		snprintf(buf, 255, "+CGDCONT: (1-2),\"IP\",,,(0-2),(0,1,2,3,4)");
>> +		snprintf(buf, 255, "+CGDCONT: (1-%d),\"IP\",,,(0-2),(0,1,2,3,4)",
>> +					idmap_get_size(cid));
> , but use the size of the cid_map in the CGDCONT=3D? implementation below.
>   These sizes are highly unlikely to match.
>
> However, this brings up a more fundamental question from me.  What do
> you actually want to expose here?  Do you want the emulator to be able
> to view / edit contexts exposed over D-Bus?
>
> Or is it enough to simply fake all this and maintain the cgdcont list in
> memory for each emulator instance?
>
>>   		ofono_emulator_send_info(em, buf, FALSE);
>>   		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
>>   		ofono_emulator_send_final(em,&result);
>> @@ -2888,7 +2909,8 @@ static void cgdcont_cb(struct ofono_emulator *em,
>>   		break;
>>
>>   	case OFONO_EMULATOR_REQUEST_TYPE_QUERY:
>> -		result.type =3D OFONO_ERROR_TYPE_FAILURE;
>> +		ofono_gprs_list_contexts(em, gprs);
>> +		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
>>   		ofono_emulator_send_final(em,&result);
>>   		break;
>>   	case OFONO_EMULATOR_REQUEST_TYPE_SET:
> Regards,
> -Denis


--===============1680420860960237706==--

