Content-Type: multipart/mixed; boundary="===============6619072273419164278=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: RE: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Wed, 23 Feb 2011 16:36:32 +0000
Message-ID: <8281606748F03E4390BB98A3F47F2E948A9F98CDC7@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4D652E8D.2020404@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6619072273419164278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


>> In my opinion, combined gprs atom would be easier to do and probably =

>> enough, separate atoms would be more "looking into the future" like =

>> but I am not sure if this division is necessary.
>
>Looking at the current ConnectionManager API, none of the properties =

>(Powered, Attached, Suspended, RoamingAllowed) are applicable to LTE.
>If we use a separate LTE atom then the Bearer property's 'lte' value is =

>redundant as well.  So why would you want to carry this baggage around =

>for the user of LTE-only systems?

After discussing internally with Fred Joly I would like to come back on the=
 4 properties :
- Suspended is applicable in LTE in case of CS Voice Call using CSFB
- Powered is applicable the only point is that you'll not be registered to =
LTE network if PS is disabled.
- Attached is also applicable and here also if you are not attached then yo=
u'll not be registered to LTE network.
- RoamingAllowed it's a settings from the APE so we can imagine that we wou=
ld like not to use LTE if we are in roaming.

Our understanding is that LTE is a GSM technology so it's normal to have GS=
M concepts behind.


Regards,

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============6619072273419164278==--

