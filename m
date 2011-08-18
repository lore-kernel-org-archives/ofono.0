Content-Type: multipart/mixed; boundary="===============2981873174082115680=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 1/5] Mobile broadband provider info plugin
Date: Thu, 18 Aug 2011 13:37:02 -0500
Message-ID: <4E4D5BCE.7040901@gmail.com>
In-Reply-To: <4E4A7A9F.8050208@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2981873174082115680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 08/16/2011 09:11 AM, Oleg Zhurakivskyy wrote:
> Hello Denis,
> =

> On 08/12/2011 09:55 AM, Denis Kenzior wrote:
>>> +static struct ofono_gprs_provision_data *apn_try_new(struct
>>> parser_data *data)
>>> +{
>>> +    void *p;
>>> +
>>> +    p =3D g_try_realloc(*data->settings,
>>> +                sizeof(struct ofono_gprs_provision_data) *
>>> +                (data->count + 1));
>>> +    if (p =3D=3D NULL)
>>> +        return NULL;
>>> +
>>> +    *data->settings =3D p;
>>> +
>>> +    data->context =3D *data->settings + data->count++;
>>> +
>>> +    memset(data->context, 0, sizeof(struct ofono_gprs_provision_data));
>>
>> This seems like a really big hammer.  We have 3 settings we're likely to
>> provision, internet, wap, mms.  The function runs synchronously and
>> oFono is not threaded.  So in theory you can allocate the context
>> information statically and only copy it to the caller once you have
>> completed the parser.
> =

> Hmm, statically allocated array of settings was in the previous version.
> Then the wish was to make it dynamic and to use realloc. Can we settle
> on an approach here?
> =


The preference is to always allocate statically if you can get away with
it; if you do not need to use malloc/realloc, then please don't.  I do
not believe the earlier feedback you received is in conflict here.

Using a static array for the parser and only allocating the return array
is the preferred approach since we should not be returning more than 1
internet, 1 wap and 1 mms setting.  If you have multiple of any of these
then you should not provision as it indicates that user's input is required.

Regards,
-Denis

--===============2981873174082115680==--

