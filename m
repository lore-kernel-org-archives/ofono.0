Content-Type: multipart/mixed; boundary="===============1575684023718946670=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/1] atmodem/lte: Gemalto vendor specific extension
Date: Mon, 15 Oct 2018 13:37:11 -0500
Message-ID: <dd10f6ab-9ab8-3a31-f2f5-c11f49abb0dc@gmail.com>
In-Reply-To: <CAKSBH7E2+Bv2+nqOWDsUhM+DH-+YmEhsmnegF1pwgqbByDTYeQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1575684023718946670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>> Given that, polluting atutil.c with vendor-specific code is not a great
>> idea.  Even though you don't want to repeat the same code in lte.c and
>> gprs-context.c, it's not a big deal to do so, and the code is probably
>> easier to follow that way anyway.
> =

> What about introducing a vendor.c ?

I will mostly echo what Jonas already said.  There should be no vendor =

specific code in drivers/atmodem/atutil.c.  The VENDOR tweaks are really =

meant as just that.  Tweaks to AT commands that were broken by the =

vendor, or tweaks to behavior because the firmware says one thing but =

really means another.

Once you get into a situation where you have an entirely different set =

of AT commands being used, then you really need to consider using a =

separate driver.  Even if that means duplicating some code which is =

generic 27.007.  The generic 27.007 part can actually be put inside =

atutil.c, so you can avoid (some) code duplication that way.

Regards,
-denis

--===============1575684023718946670==--

