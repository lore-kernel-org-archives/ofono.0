Content-Type: multipart/mixed; boundary="===============6937027131758377352=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: Re: [PATCH 1/2] atmodem: move USSD quirk to probe and use it also for
 STE modems
Date: Tue, 18 Jan 2011 15:17:59 +0200
Message-ID: <1295356679.10484.62.camel@lkunnasl-desktop>
In-Reply-To: <4D346712.80109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6937027131758377352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, 2011-01-17 at 17:58 +0200, Denis Kenzior wrote:
> Hi Lasse,
> =

> On 01/17/2011 02:42 AM, Lasse Kunnasluoto wrote:
> > Hi Marcel,
> > =

> Supporting IRA character set is not really an option since IRA and GSM
> 7bit have disjoint sets of characters.  The best you can really do is:
> =

> - If your modem supports UTF8, then set that for all multiplexer
> channels in the modem driver.
Yes, it supports UTF8. I'll send a new patch for this. Thanks.

> - Otherwise set the character set to GSM and do your best to put ussd
> and phonebook on separate multiplexer channels.  That is of course
> assuming that the CSCS setting is handled per channel.
> =

> > =

> >> The best is if the STE modem would provide access to the USSD in PDU
> >> mode and we can then decode it properly. Using text mode for USSD is n=
ot
> >> the best idea actually. Same as text mode for SMS is utterly broken ;)
> > Don't know if this is possible.
> =

> USSD PDU mode is the ideal solution.  If this is not available, then you
> will have to jump through all kinds of hoops to get this done properly.
> =

> Regards,
> -Denis

-Lasse


--===============6937027131758377352==--

