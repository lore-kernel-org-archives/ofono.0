Content-Type: multipart/mixed; boundary="===============6565871926829877229=="
MIME-Version: 1.0
From: Kouassu, AlainX <alainx.kouassu@intel.com>
Subject: RE: Ofono limit the max length for a phone number to 20 digit
Date: Mon, 09 Aug 2010 10:03:22 +0100
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018703218F98D@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4C5C2E3E.5060201@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6565871926829877229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for your answer.
Actually 24.008 states that the Called party BCD can have a maximum length =
of 43 octets, we are far from the 20 characters supported by Ofono.
The Calling party BCD is not mandatory when making a mobile originated voic=
e call (24.008).

I hope this could help. =


Regards,

Alain  =




-----Original Message-----
From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Sent: Friday, August 06, 2010 5:46 PM
To: ofono(a)ofono.org
Cc: Kouassu, AlainX
Subject: Re: Ofono limit the max length for a phone number to 20 digit

Hi Alain,

On 08/06/2010 09:56 AM, Kouassu, AlainX wrote:
> Is there a particular motivation for Ofono to limit the max length of a p=
hone number to 20 digit ?
> The limit to 20 digit for a phone number could be a potential risk since =
according to IUT-T a phone number can have up to 15 digit + international p=
refix. Some country have international dialing prefix greater than 6 digit. =


Limit of 20 was chosen for several reasons:

- That is the maximum incoming party number size (24.008 Calling Party
BCD Number)
- Most networks do not support Calling Party BCD number more than 20
characters (24.008 Calling Party BCD Number)
- SMS Address is limited to 20 characters (23.040)
- oFono does not support EFadn extensions, and thus numbers are limited
to 20 characters (31.102)

There might be exceptions to this where more than 20 characters are
required.  Patches are of course always welcome.

Regards,
-Denis
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


--===============6565871926829877229==--

