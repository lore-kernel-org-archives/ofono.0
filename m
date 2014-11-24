Content-Type: multipart/mixed; boundary="===============2462713384370388087=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] sms: Option HSO modem can't really do CNMA
Date: Mon, 24 Nov 2014 12:29:03 -0600
Message-ID: <547378EF.8050704@gmail.com>
In-Reply-To: <87wq6pwbu2.fsf@ossau.homelinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2462713384370388087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Neil,

 >
> oFono chooses 2 for the "mt" value, rather than 1, if it thinks that the
> modem can do "CNMA", which I think means acknowledging each SMS after it
> is transferred from the modem to the containing OS.  But:

Yes, oFono prefers using +CMT indication instead of +CMTI.  That is =

because we actually need 2 extra AT commands to process the incoming =

message instead of just 1 with +CMT.

>
> - in practice the modem never generates the +CMT indications that are
>    supposed to go with this mode of operation
>

Your modem is just weird then.

> - there are other places in the source code nearby where CNMA acking is
>    skipped for OFONO_VENDOR_OPTION_HSO.
>

Not really.  We only skip the generation of the ackpdu.  Acknowledging =

via AT+CNMA still works with the 'safe' AT+CNMA=3D0 option.  This works on =

every HSO device I have :)  Admittedly I never played with the GTA04.

> It seems this adds up to an indication that the modem doesn't really do
> CNMA, and the patch that I've submitted does the trick and allows
> incoming SMSes to be received successfully.

You might need to rework the hso driver to detect/handle the GTM601 =

separately.  Adding another vendor quirk to do so.

Regards,
-Denis

--===============2462713384370388087==--

