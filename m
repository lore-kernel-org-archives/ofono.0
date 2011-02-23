Content-Type: multipart/mixed; boundary="===============1978948016847122505=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Wed, 23 Feb 2011 10:49:37 -0600
Message-ID: <4D653AA1.8000203@gmail.com>
In-Reply-To: <8281606748F03E4390BB98A3F47F2E948A9F98CDC7@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1978948016847122505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Redouane,

On 02/23/2011 10:36 AM, Soum, RedouaneX wrote:
> Hi Denis,
> =

> =

>>> In my opinion, combined gprs atom would be easier to do and probably =

>>> enough, separate atoms would be more "looking into the future" like =

>>> but I am not sure if this division is necessary.
>>
>> Looking at the current ConnectionManager API, none of the properties =

>> (Powered, Attached, Suspended, RoamingAllowed) are applicable to LTE.
>> If we use a separate LTE atom then the Bearer property's 'lte' value is =

>> redundant as well.  So why would you want to carry this baggage around =

>> for the user of LTE-only systems?
> =

> After discussing internally with Fred Joly I would like to come back on t=
he 4 properties :
> - Suspended is applicable in LTE in case of CS Voice Call using CSFB

My understanding was that CS Fallback physically switches technologies.
 It is not 'suspending' LTE like it does with GPRS.  Am I wrong on this one?

> - Powered is applicable the only point is that you'll not be registered t=
o LTE network if PS is disabled.

It sounds like you're talking about RadioSettings properties here.

Powered=3DFalse is implemented by simply not attaching today.  The
implementation logic for LTE would be completely different.  So most
likely this will not work out nicely anyway.

> - Attached is also applicable and here also if you are not attached then =
you'll not be registered to LTE network.

Sounds pointless to expose for LTE to me.

> - RoamingAllowed it's a settings from the APE so we can imagine that we w=
ould like not to use LTE if we are in roaming.

Perhaps, but again we have no control of the attach procedure with LTE.
 So the implementation has to rely on vendor specific radio settings.
Same arguments about shoehorning logic apply here.

Regards,
-Denis

--===============1978948016847122505==--

