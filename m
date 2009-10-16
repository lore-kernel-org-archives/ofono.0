Content-Type: multipart/mixed; boundary="===============0622924409761384155=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Parse +CUSD responses.
Date: Fri, 16 Oct 2009 17:47:04 -0500
Message-ID: <200910161747.05507.denkenz@gmail.com>
In-Reply-To: <fb249edb0910161412l7bf189bar4eb9a28062df067c@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0622924409761384155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > Actually valid_ussd_string will accept just about everything.
>
> Ah true.  However I think we should never try to send a UCS2 USSD - we
> would first need to know that the modem supports this (so a vendor
> quirk set by the plugin would tell us this) and then that the network
> supports this too.

You're absolutely right that we shouldn't, I was just pointing out the need=
 to =

always be paranoid ;)

> > What about the evil set of DCSes which indicate a ISO639 2 character co=
de
> > preceding the message?
>
> The comment refers to this.  I think 27.007 tries to say the modem has
> to take care of this and only give us the actual characters of the
> string.
>
> "-       if TE character set other than "HEX" (refer command Select TE
> Character Set +CSCS): MT/TA converts GSM alphabet into current TE
> character set according to rules of 3GPP TS 27.005 [24] Annex A

So this part really only talks about the modem performing character set =

conversion between GSM and IRA/UCS2/UTF8 or whatever is set by CSCS.  I =

suspect the DCS is simply never looked at by most networks/modems :)

Patch has been applied, with some fixes afterward.  I think this is good en=
ough =

until we find a network / modem that supports this stuff properly.

Regards,
-Denis

--===============0622924409761384155==--

