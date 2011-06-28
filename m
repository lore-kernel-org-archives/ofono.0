Content-Type: multipart/mixed; boundary="===============8290977595618201730=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v3 1/4] GAtPPP: Add ACFC option support
Date: Tue, 28 Jun 2011 18:29:52 -0500
Message-ID: <4E0A63F0.8070607@gmail.com>
In-Reply-To: <1309310665.2208.29.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8290977595618201730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 06/28/2011 08:24 PM, Marcel Holtmann wrote:
> Hi Denis,
> =

>>> @@ -658,6 +703,11 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const c=
har *remote,
>>>  	ipcp_set_server_info(ppp->ipcp, r, d1, d2);
>>>  }
>>>  =

>>> +void g_at_ppp_set_acfc_enabled(GAtPPP *ppp)
>>
>> I really do want the signature to be g_at_ppp_set_acfc_enabled(GAtPPP
>> *ppp, gboolean enabled)
>>
>> There are cases where we might re-use the PPP object with different
>> parameters.
> =

> what is wrong with just g_at_ppp_set_acfc(GAtPPP *ppp, gboolean enabled)
> as function name. Duplicating enabled in the function name and as
> parameter seems to be bit odd.

For APIs I generally prefer:

_set_foo() when foo is a 'thing', e.g int/string/struct/etc

and _set_foo_enabled() when foo is on/off as that intent is clearer when
reading the code.

Regards,
-Denis

--===============8290977595618201730==--

