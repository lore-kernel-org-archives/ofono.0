Content-Type: multipart/mixed; boundary="===============3658989908376517247=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/12] Modify ussd parser
Date: Wed, 16 Jun 2010 17:48:13 -0500
Message-ID: <201006161748.13719.denkenz@gmail.com>
In-Reply-To: <1276422202-16240-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3658989908376517247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> * Original code doesn't call unpack_7bit(), which seems not correct.
> * An utility function is used to handle it, which supports 8-bit
> and ucs2 besides 7-bit character.
> * Status is assigned with correct value when error occurs

Please drop this patch for now, the problem is that all AT modems do not =

actually report USSD data as a PDU, instead they actually decode this into =
the =

current character set of the modem (as set by +CSCS.)  The spec really scre=
wed =

up on this one.

This is one of the weirder parts of the spec, I don't think USSDs that are =
not =

GSM 7 bit are even possible.  At least not on the AT modems I've encountere=
d.

Feel free to investigate this further.

Regards,
-Denis

--===============3658989908376517247==--

