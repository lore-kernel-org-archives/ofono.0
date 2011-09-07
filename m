Content-Type: multipart/mixed; boundary="===============2281019234669885523=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv5 3/3] Mobile broadband provider info plugin
Date: Wed, 07 Sep 2011 15:38:58 +0300
Message-ID: <4E6765E2.3020503@intel.com>
In-Reply-To: <4E5C9C95.1000105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2281019234669885523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 08/30/2011 11:17 AM, Denis Kenzior wrote:
> The mobile-broadband-provider-info database would probably need to be
> extended with a fully-fledged SPN element to store this information.
> The current database is simply not setup this way.  To give you an
> example, in Australia most providers have the SPN structured something
> like this:
> '<ProviderName>  AU'
>
> So it is quite obvious why your logic above will fail ;)
>
> Other times the SPN name is a shortened / stylized name of the provider,
> e.g. Virgin Mobile ->  Virgin
>
> The current<name>  tag under the<provider>  tag is really for the user's
> benefit.

If the provider name isn't sufficient to serve as the SPN, shall we add opt=
ional =

SPN element on the same level?

<provider>
	<name>...</name>
	<spn>...</spn>
	<network-id mcc=3D"123" mnc=3D"12"/>
	<apn>...</apn>
</provider>

Can we drop this check until such SPN element can be upstreamed into the da=
tabase?

>> For some tags, the parser calls body multiple times, first few times
>> supplying just '\n' and '\t's. Also, some tags have such a body that
>> DBG() has trouble to print without escaping. So, what's the method to
>> protect against the latter?
>
> This might be easier if you only run the parser on the bodies of the
> tags you really care about.  e.g. this problem might just go away when
> you use g_markup_parse_context_push/pop.

This place in the parser is already run only on bodies we care about, i.e. =

within mcc/mnc match. If the diagnostics on body is required, this problem =
won't =

go away if we use g_markup_parse_context_push/pop. So, do we keep the escap=
ing =

or drop diagnostics of the element body? Or, propose a solution?

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============2281019234669885523==--

