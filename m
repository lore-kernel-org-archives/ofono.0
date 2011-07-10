Content-Type: multipart/mixed; boundary="===============7674162245069410298=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 1/1] GPRS Provisioning Plugin.
Date: Sun, 10 Jul 2011 09:23:15 -0500
Message-ID: <4E19B5D3.1070407@gmail.com>
In-Reply-To: <201107111111.39453.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7674162245069410298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 07/11/2011 03:11 AM, R=C3=A9mi Denis-Courmont wrote:
> On Friday 08 July 2011 21:23:34 ext Denis Kenzior, you wrote:
>> Hi Oleg,
>>
>> <snip>
>>
>>> +static int gprs_provision(const char *mcc, const char *mnc,
>>> +				const char *spn,
>>> +				struct ofono_gprs_provision_data **settings,
>>> +				int *count)
>>> +{
>>> +	int i;
>>> +	struct parser_data *data;
>>> +	*settings =3D NULL;
>>> +
>>> +	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'",
>>> +			mcc, mnc, spn);
>>> +
>>> +	data =3D g_try_new0(struct parser_data, 1);
>>> +	if (data =3D=3D NULL)
>>> +		return -ENOMEM;
>>> +
>>> +	lookup_apn(mcc, mnc, NULL, data);
>>
>> What I wonder is what is the overhead of the XML parser right now (e.g.
>> how long it takes on reasonable embedded hardware).  If this takes a
>> while, then it might be better to pre-parse the mobile-provider-info db
>> during plugin initialization and not every time gprs_provision is
>> called.  Otherwise we run the risk of hanging the daemon while the
>> provision settings are being looked up.
> =

> Provisioning should be a fairly rare occurence. Preparsing the table into =

> memory might be a waste of both CPU and memory in the common circumstance=
s...
> =


I do agree here, but it is the lesser evil than hanging the daemon for x
seconds.  However, first I'd like to know what the parsing speed is...

> If you suspect the parser is slow (I doubt it, but I have not checked), t=
hen =

> it might be better to just do it in a separate thread in the rare cases t=
hat =

> you actually do need the data.
> =


Separate thread will not help since the function has to return
synchronously.  I doubt the overhead of storing this information will be
big, but if it is then we can play other tricks like pre-parsing the db
into a quick-look-up file format at start-up, etc.

Regards,
-Denis

--===============7674162245069410298==--

