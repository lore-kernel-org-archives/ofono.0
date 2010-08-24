Content-Type: multipart/mixed; boundary="===============7922610638213255473=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Support text mode sms send and receive
Date: Tue, 24 Aug 2010 13:51:37 -0500
Message-ID: <4C7414B9.40606@gmail.com>
In-Reply-To: <C6FAFDDBC4402D44BFC43E57565F0219039D85CD@ala-mail09.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7922610638213255473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Su Yong,

On 08/23/2010 04:11 AM, Su, Yong wrote:
> Hi, all:
>  =

> Our project used ZTE EVDO modem. But this modem only supports sending
> and receiving sms with text mode.
> I have modify oFono gatchat code to support this. But it conflicted with
> original gatchat architecture.
> Does oFono plan to support text mode sms send&receive?
>  =

>  =


So oFono explicitly does not want to support text mode.  There are many
reasons for this, but let me list the most important ones:

- oFono core deals with raw PDUs.  That is the universal standard
between AT modems and binary protocol based modems.  This PDU format is
well understood, simple to decode / generate and the utilities in oFono
cover just about every use case.  If you decide to do text mode, then
you will have to:
	- Solve the AT command parser issues
	- Collect all the SMS pieces
	- Encode them back into a PDU

At which point oFono will take the PDU and decode it back to something
that can be used.  This is a MAJOR waste of CPU power and resources.
Changing the driver API here is highly unlikely.

This is not to mention other interaction problems which depend on PDU
mode being available (e.g. Sim Toolkit Send SMS, SMS-PP Data Download, etc)

- Text mode depends on setting or otherwise messing with +CSCS.  Most AT
command based modems do not handle this very gracefully.  Most other
drivers will expect the IRA character set and you will start random
errors.  There's of course a chance that your modem can handle this
properly (perhaps you have a decent multiplexer implementation in which
CSCS affects a single channel only, _and_ you wall-off the SMS part on
that multiplexer channel), but my experience with GSM modems leaves me
extremely skeptical.

- The AT parser for this is essentially a disaster area.  Every modem
has its own quirks for text mode.  It is something that a human being
can understand and work around, but for a library like GAtChat the
complexity will be huge.  Even if you make it work on this particular
modem, it _has_ to work on other modems as well.

Please note that there are no modern GSM telephony stacks that use text
mode SMS for exactly those reasons.  So the question is, can you ask
your modem manufacturer to provide firmware that supports PDU mode?

Regards,
-Denis

--===============7922610638213255473==--

