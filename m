Content-Type: multipart/mixed; boundary="===============7615759014916505280=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RAT , signal Strength indication ofono 0.23
Date: Wed, 18 Aug 2010 09:10:07 -0500
Message-ID: <4C6BE9BF.3030409@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D401870321E1E0E@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7615759014916505280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alain,

On 08/18/2010 03:09 AM, Kouassu, AlainX wrote:
> HI Denis,
> =


Just a kind reminder to stop top-posting on this mailing list.  Please
observe our netiquette here.

> In fact the property like CellId or LocationAreaCode are sometimes update=
d but the property Technology (RAT) is never indicated, in the other hand t=
he property Strength is not updated when the signal strength of the cell ch=
ange. Is sound like networkregistration API is not fully working or impleme=
nted ?

There are two players here, oFono core and the modem driver.  There are
no known issues with the core, but it relies on the driver to work
properly.  LAC / CI, signal strength reporting works just fine on other
hardware and has been working for quite some time.

Since you're using a modem / driver that is not upstream and have not
provided an AT Command debug log we don't have enough information to
diagnose the problem.

For signal strength and technology reporting most vendors use
proprietary AT commands.  Perhaps your modem's netreg driver is not
integrated properly?

> =

> Thanks,
> Alain Kouassu

Regards,
-Denis

--===============7615759014916505280==--

