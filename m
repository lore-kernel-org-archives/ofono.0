Content-Type: multipart/mixed; boundary="===============9214669638126240342=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 21:31:56 -0500
Message-ID: <1d96c891-a2c6-65e2-8dee-f77fb1e3c367@gmail.com>
In-Reply-To: <49ad6936-1138-996e-5bcb-48f421e1b371@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9214669638126240342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 09/19/2018 06:14 PM, Slava Monich wrote:
> On 20/09/18 00:45, Denis Kenzior wrote:
>>> (ANY =3D PAP_CHAP, and don't ask me why we added new values to the =

>>> beginning of the enum - it was before we started using binary =

>>> plugins). I would be more than happy if upstream started to use the =

>>> same enum!
>>>
>>
>> That assumes that we should support your METHOD_ANY thing.=C2=A0 I've no=
t =

>> heard any good arguments for that yet...
> =

> At least one Chinese modem I dealt with had AT+ EGPAU =3D <op>,<cid>, =

> <proto> where <proto> is 0 for PAP, 1 for CHAP, 2 for NONE and 3 for =

> PAP_CHAP. Also, Android RIL interface has value 3 reserved for PAP&CHAP =

> (see ril.h for older Androids and ApnAuthType in binder radio interface =

> for Android 8+). To me that sounds like a valid use case.

So I went in and checked (someone can correct me if I'm wrong)

- The three-four generations of Intel modems I checked do not support this
- QMI doesn't support this
- MBIM doesn't support this (but supports MSChap/MSChapV2, funnily enough)
- 3GPP doesn't support this
- Telit doesn't support this
- Model Broadband Provider Info doesn't support this

Are you sure it isn't some weird vendor feature where they try all =

possibilities one at a time?  E.g. it tries CHAP first, then tries PAP, =

then tries None?

And how do you plan on supporting this on modems that physically do not =

support such an enumeration?  What would be the exact semantics?  Is =

this modem supported by oFono upstream?

This conversation is moot until you introduce support for such a modem =

or more specific information is introduced.  And until / unless this =

happens, we're not introducing random enumerations into the D-Bus API =

that we have to live with for a long time.

Regards,
-Denis

--===============9214669638126240342==--

