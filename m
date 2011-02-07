Content-Type: multipart/mixed; boundary="===============2660698741367745673=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/12] gprs: driver interface changes for IPv6
Date: Mon, 07 Feb 2011 10:32:14 -0600
Message-ID: <4D501E8E.4020100@gmail.com>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC2985A8@008-AM1MPN1-001.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2660698741367745673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 02/07/2011 03:55 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Denis,
> =

> Thanks for the comments. =

> =

>>> +enum ofono_gprs_addrconf {
>>> +	OFONO_GPRS_ADDRCONF_NONE,
>>> +	OFONO_GPRS_ADDRCONF_STATIC,
>>> +	OFONO_GPRS_ADDRCONF_DHCP,
>>> +};
>>> +
>>
>> What exactly is the _NONE addrconf for?  And why don't we use =

>> a gboolean
>> here like before?
> =

> Neither "static" nor "DHCP" makes sense for IPv6. If we have an IPv6 only=
 context, the "Method" property will not show up at all.

What about combined V4 V6 contexts? What method do you use there, since
NONE doesn't exactly fit?  I'd rather see this be ignored for IPv6
contexts or that we separate the IPv4 and IPv6 configuration into two
separate batches.

Regards,
-Denis

--===============2660698741367745673==--

