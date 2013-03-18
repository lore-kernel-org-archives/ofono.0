Content-Type: multipart/mixed; boundary="===============4029623229887579453=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v0 06/20] hfp_hf_bluez5: Add HFP 1.6 connect implementation
Date: Mon, 18 Mar 2013 14:15:42 -0500
Message-ID: <514767DE.1050201@gmail.com>
In-Reply-To: <20130314175245.GA2649@samus>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4029623229887579453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 03/14/2013 12:52 PM, Vinicius Costa Gomes wrote:
> Hi,
>
> On 11:21 Tue 12 Mar, Claudio Takahasi wrote:
>> This patch implements the HF initiate SCO connection for devices
>> compliant with HFP 1.6. HF sends AT+BCC to inform the AG that audio
>> connection is required.
>> ---
>>   plugins/hfp_hf_bluez5.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
>> index 0d5d5c7..6c55657 100644
>> --- a/plugins/hfp_hf_bluez5.c
>> +++ b/plugins/hfp_hf_bluez5.c
>> @@ -364,7 +364,18 @@ static struct ofono_handsfree_card_driver card_driv=
er15 =3D {
>>   static int card_audio_connect16(const char *remote, const char *local,
>>   								void *data)
>>   {
>> -	return 0;
>> +	struct ofono_modem *modem =3D data;
>> +	struct hfp *hfp =3D ofono_modem_get_data(modem);
>> +	struct hfp_slc_info *info =3D&hfp->info;
>> +
>> +	if (info->chat =3D=3D NULL)
>> +		return -ENOTCONN;
>> +
>> +	info->chat =3D g_at_chat_ref(info->chat);
>> +	g_at_chat_send(info->chat, "AT+BCC", NULL, NULL, info->chat,
>> +					(GDestroyNotify) g_at_chat_unref);
>
> Testing with the iPhone, if there's no audio related things happening on
> the phone, audio calls for example, the phone responds with an error.
>
> We need to handle this case, we could think of two alternatives:
>
> 1. Adding a timeout when the driver returns -EINPROGRESS, if this timeout
> expires before the SCO is established we return an error to the caller of=
 the
> Connect method;

Sounds fine

>
> 2. Adding another method to the handsfree-audio.h API, something like:
> "ofono_handsfree_audio_card_falied(card, err)" that would signify that the
> audio connection attempt failed before its time.

No, don't do this

>
> The main advantage of (1) is that we are covered even in the case that
> "AT+BCC" succeeds and the remote device doesn't open an SCO channel.
>

The problem is that the spec does not suggest any timing relationship =

between AT+BCC and the SCO establishment.  I suggest we ignore this case =

for now and simply return success / failure from Connect() based on the =

result of AT+BCC.

>
>> +
>> +	return -EINPROGRESS;
>>   }
>>
>>   static struct ofono_handsfree_card_driver card_driver16 =3D {
>> --
>> 1.7.11.7
>>
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> http://lists.ofono.org/listinfo/ofono
>
>
> Cheers,

Regards,
-Denis

--===============4029623229887579453==--

