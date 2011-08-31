Content-Type: multipart/mixed; boundary="===============1186856542030365119=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv5 3/3] Mobile broadband provider info plugin
Date: Wed, 31 Aug 2011 03:25:29 -0500
Message-ID: <4E5DEFF9.20308@gmail.com>
In-Reply-To: <4E6765E2.3020503@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1186856542030365119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 09/07/2011 07:38 AM, Oleg Zhurakivskyy wrote:
> Hello Denis,
> =

> On 08/30/2011 11:17 AM, Denis Kenzior wrote:
>> The mobile-broadband-provider-info database would probably need to be
>> extended with a fully-fledged SPN element to store this information.
>> The current database is simply not setup this way.  To give you an
>> example, in Australia most providers have the SPN structured something
>> like this:
>> '<ProviderName>  AU'
>>
>> So it is quite obvious why your logic above will fail ;)
>>
>> Other times the SPN name is a shortened / stylized name of the provider,
>> e.g. Virgin Mobile ->  Virgin
>>
>> The current<name>  tag under the<provider>  tag is really for the user's
>> benefit.
> =

> If the provider name isn't sufficient to serve as the SPN, shall we add
> optional SPN element on the same level?
> =

> <provider>
>     <name>...</name>
>     <spn>...</spn>
>     <network-id mcc=3D"123" mnc=3D"12"/>
>     <apn>...</apn>
> </provider>
> =

> Can we drop this check until such SPN element can be upstreamed into the
> database?
> =


Yes, this is exactly what I'd like to do.

>>> For some tags, the parser calls body multiple times, first few times
>>> supplying just '\n' and '\t's. Also, some tags have such a body that
>>> DBG() has trouble to print without escaping. So, what's the method to
>>> protect against the latter?
>>
>> This might be easier if you only run the parser on the bodies of the
>> tags you really care about.  e.g. this problem might just go away when
>> you use g_markup_parse_context_push/pop.
> =

> This place in the parser is already run only on bodies we care about,
> i.e. within mcc/mnc match. If the diagnostics on body is required, this
> problem won't go away if we use g_markup_parse_context_push/pop. So, do
> we keep the escaping or drop diagnostics of the element body? Or,
> propose a solution?

I still think that the reasons for your escaping logic are flawed.  I
suggest that you study the problem and get a better understanding why
this happens in the first place.

For example:
<network-id mcc=3D"412" mnc=3D"01"/>
<apn value=3D"internet">
	<username>awcc</username>
	<password>1111</password>
</apn>

I expect the body callback to be called with random \r\t\n garbage for
the APN tag.  However, this is not something we care about anyway and
can ignore (e.g. with a call to g_markup_parse_context_push)

For username/password bodies we shouldn't even have \r\t\n characters in
there in the first place.  Certainly the naive escaping mechanism you
have now won't work with UTF-8 strings.

Regards,
-Denis

--===============1186856542030365119==--

