Content-Type: multipart/mixed; boundary="===============8907029129680391770=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] gprs: Add private APIs to activate/deactivate
 private contexts
Date: Thu, 30 Jun 2011 01:11:07 -0500
Message-ID: <4E0C137B.9010200@gmail.com>
In-Reply-To: <4E0CA34B.2000903@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8907029129680391770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>>>   static GSList *g_drivers =3D NULL;
>>>   static GSList *g_context_drivers =3D NULL;
>>> +static GSList *g_private_contexts =3D NULL;
>>
>> So this part is quite wrong ;)  What you have done here is to make stk
>> activated contexts shared across all gprs atoms, with potentially
>> duplicate ids.
>>
> =

> The gprs_private_contexts are linked to one specific gprs atom as for
> ofono_gprs_contexts. So, I don't understand your point.
> Also, could we think to have more than one gprs atom? In which condition?
> =


You are using a global variable, such that this list is shared across
all atoms.  Remember, oFono has multiple modem objects, each one having
a gprs atom.  The idmap for each gprs atom is independent, so your
gprs_private_context_by_id implementation will fall flat on its face as
soon as you have multiple STK enabled modems in the system ;)

> The idea of this list was to offer the possibility to active/deactivate
> a private context from any atom, not only STK. Hence, the private
> context is not specifically an STK context.
> If we consider that this is not really useful, I can handle only one
> static _gprs_private_context_ pointer.
> This way, it means also that we don't need to return a cid to the STK ato=
m.
> =

> So, I presume, I should simplify and remove this list?
> =


This thought did come across my mind when I reviewed this patch.
Honestly I don't ever see a case where we would need to activate a
context outside of stk.  And I don't think stk is ever going to activate
multiple contexts...

Certainly this simplification will make the API and implementation a bit
cleaner without having any negative impact.

Regards,
-Denis

--===============8907029129680391770==--

