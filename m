Content-Type: multipart/mixed; boundary="===============5282862652236469051=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv3 1/5] Mobile broadband provider info plugin
Date: Tue, 16 Aug 2011 17:11:43 +0300
Message-ID: <4E4A7A9F.8050208@intel.com>
In-Reply-To: <4E44CE68.7040404@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5282862652236469051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 08/12/2011 09:55 AM, Denis Kenzior wrote:
>> +static struct ofono_gprs_provision_data *apn_try_new(struct parser_data=
 *data)
>> +{
>> +	void *p;
>> +
>> +	p =3D g_try_realloc(*data->settings,
>> +				sizeof(struct ofono_gprs_provision_data) *
>> +				(data->count + 1));
>> +	if (p =3D=3D NULL)
>> +		return NULL;
>> +
>> +	*data->settings =3D p;
>> +
>> +	data->context =3D *data->settings + data->count++;
>> +
>> +	memset(data->context, 0, sizeof(struct ofono_gprs_provision_data));
>
> This seems like a really big hammer.  We have 3 settings we're likely to
> provision, internet, wap, mms.  The function runs synchronously and
> oFono is not threaded.  So in theory you can allocate the context
> information statically and only copy it to the caller once you have
> completed the parser.

Hmm, statically allocated array of settings was in the previous version. Th=
en =

the wish was to make it dynamic and to use realloc. Can we settle on an app=
roach =

here?

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============5282862652236469051==--

