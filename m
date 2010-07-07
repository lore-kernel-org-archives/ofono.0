Content-Type: multipart/mixed; boundary="===============9179424202694235547=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: FYI: Emergency calls with MBM modem
Date: Wed, 07 Jul 2010 10:47:45 -0500
Message-ID: <4C34A1A1.50006@gmail.com>
In-Reply-To: <AANLkTiklQhayPAhums1pWVC43_u_GUYiyDJzEQifik7H@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9179424202694235547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 07/07/2010 08:19 AM, Pekka Pessi wrote:
> Hi all,
> =

> I just did some emergency calls in our lab with the Ericsson MBM modem
> (3507g). The modem firmware has the voice calls enabled, even while
> there is no audio input/output from the modem (as far as I know).
> =

> Main results are:
> - emergency calls are not possible in offline mode (CFUN=3D4), ATD112;
> returns NO DIALTONE

That was expected, do we have a solution in mind on how to do emergency
dialing in Offline mode?  Is it a UI problem?

> - emergency calls can be made without SIM card (but they require AT+CFUN=
=3D1)

That was again expected...

> - most MBM modem functionality (AT+COPS, AT+CLCC does not work without SI=
M card)

The only one that can be triggered without a SIM card is AT+CLCC.
However, please note that MBM should not be using CLCC, but instead its
own vendor-specific voicecall extensions.

> - emergency calls cannot be handled with usual AT+CHLD commands (e.g.,
> AT+CHLD=3D11 does not hang up emergency calls)

That is a bit nasty, is there an assumption that every other call is
hung up when an emergency number is dialed?

>   (ofono cannot hangup emergency call and it does not notice when it ends)
> - emergency call gets number "112" and type 128 (unknown type of
> number and numbering plan)

Again, most likely because MBM uses its own voicecall extensions.
Driving it with CLCC is wrong...

> =

> Please find attached log. I first made call to 99999 (an ordinary
> service number within our lab network) then 118 (non-existing service
> number) then 112 (emergency call).
> =

> The emergency call was terminated by callee around 02:58:52 (as you
> can see, modem indicates it with +CIEV=3D8,0).

These are Bluetooth Handsfree indicators btw, not typically used for
driving a real modem...

Regards,
-Denis

--===============9179424202694235547==--

