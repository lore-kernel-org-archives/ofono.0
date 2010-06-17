Content-Type: multipart/mixed; boundary="===============0709934728370109612=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/12] Modify ussd parser
Date: Thu, 17 Jun 2010 04:35:38 -0500
Message-ID: <201006170435.39056.denkenz@gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731ED17F93@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0709934728370109612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> >Please drop this patch for now, the problem is that all AT modems do not
> >actually report USSD data as a PDU, instead they actually decode this in=
to
> > the current character set of the modem (as set by +CSCS.)  The spec
> > really screwed up on this one.
> >
> >This is one of the weirder parts of the spec, I don't think USSDs that a=
re
> > not GSM 7 bit are even possible.  At least not on the AT modems I've
> > encountered.
> =

> When it's GSM 7-bit, is it needed to call unpack_7bit() before calling
>  convert_gsm_to_utf8()? The isimodem does so. Also the status doesn't have

Again, the AT modems do not pass in a raw PDU here unlike isi modems.  They =

just give you the string in whatever the character set is set with +CSCS.  =
If =

it happens to be UTF8, it will be UTF8.  If it happens to be GSM, it'll be =

GSM.  The current driver just assumes GSM, however we really need to know t=
he =

character set.  Generally this works out because the characters are ASCII, =
but =

the current driver does not work in all situations.

>  an initial value, so in some path of code status would have an uncertain
>  value, which may cause problem when calling ofono_ussd_notify(). Maybe t=
he

I don't see any issue, from what I can tell status is always set appropriat=
ely =

before calling ussd_notify.  Can you be more specific about your concern he=
re?

Regards,
-Denis

--===============0709934728370109612==--

