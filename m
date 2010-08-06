Content-Type: multipart/mixed; boundary="===============4306246657860308403=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono limit the max length for a phone number to 20 digit
Date: Fri, 06 Aug 2010 10:46:06 -0500
Message-ID: <4C5C2E3E.5060201@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018703218F8F6@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4306246657860308403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

--===============4306246657860308403==--

