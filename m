Content-Type: multipart/mixed; boundary="===============8407832416277261120=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v3 1/4] GAtPPP: Add ACFC option support
Date: Tue, 28 Jun 2011 18:40:01 -0500
Message-ID: <4E0A6651.2080503@gmail.com>
In-Reply-To: <1309311529.2208.36.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8407832416277261120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 06/28/2011 08:38 PM, Marcel Holtmann wrote:
> Hi Denis,
> =

>>>>> @@ -658,6 +703,11 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const=
 char *remote,
>>>>>  	ipcp_set_server_info(ppp->ipcp, r, d1, d2);
>>>>>  }
>>>>>  =

>>>>> +void g_at_ppp_set_acfc_enabled(GAtPPP *ppp)
>>>>
>>>> I really do want the signature to be g_at_ppp_set_acfc_enabled(GAtPPP
>>>> *ppp, gboolean enabled)
>>>>
>>>> There are cases where we might re-use the PPP object with different
>>>> parameters.
>>>
>>> what is wrong with just g_at_ppp_set_acfc(GAtPPP *ppp, gboolean enabled)
>>> as function name. Duplicating enabled in the function name and as
>>> parameter seems to be bit odd.
>>
>> For APIs I generally prefer:
>>
>> _set_foo() when foo is a 'thing', e.g int/string/struct/etc
>>
>> and _set_foo_enabled() when foo is on/off as that intent is clearer when
>> reading the code.
> =

> fair enough.
> =

> However we have not been 100% consistent then here.
> =

> g_at_server_set_echo()
> g_at_hdlc_set_no_carrier_detect()
> =

> Both look at bit fishy with this API intention. Should we fix them as
> well then while at it?

Yes, I think set_echo definitely should become set_echo_enabled

set_no_carrier_detect_enabled would pretty long and I wouldn't mind
having a better name for this one...

Regards,
-Denis

--===============8407832416277261120==--

