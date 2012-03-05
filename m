Content-Type: multipart/mixed; boundary="===============4731934895666725494=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [Gta04-owner] Polling CLCC error handling on Option modem (GTA04)
Date: Mon, 05 Mar 2012 13:46:20 -0600
Message-ID: <4F55180C.1050501@gmail.com>
In-Reply-To: <201203062130.41546.psonek2@seznam.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4731934895666725494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Radek,

On 03/06/2012 03:30 PM, Radek Polak wrote:
> On Tuesday 06 March 2012 20:17:32 Dr. H. Nikolaus Schaller wrote:
> =

>> @Radek: is it possible to manually contact the AT interface in this state
>> and try if it is still operational and another AT+CLCC would succeed?
> =

> It seems after few errors it starts working again - if i understand it ri=
ght =

> (see log below). Btw the probability of +CME ERROR increases with smaller=
 CLCC =

> interval.
> =


FYI, CME ERROR: 100 means: "Unknown Error".  This firmware is rather
helpful here isn't it?

> So ingoring the error and trying again is the way to go for us?
> =


That sounds like your only avenue at this point.  If you're doing this
in oFono, then I would create an Option / GTA04 specific vendor quirk
for the voicecall driver.  When this quirk is set, ignore CME ERROR 100
errors (not any others) and retry the CLCC poll.

Regards,
-Denis

--===============4731934895666725494==--

