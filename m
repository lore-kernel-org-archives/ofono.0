Content-Type: multipart/mixed; boundary="===============0571173062688006334=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Polling CLCC error handling on Option modem (GTA04)
Date: Mon, 05 Mar 2012 15:59:32 -0600
Message-ID: <4F553744.4040702@gmail.com>
In-Reply-To: <877gyx1hm8.fsf@neil-laptop.ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0571173062688006334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On 03/06/2012 04:37 PM, Neil Jerram wrote:
> Denis Kenzior <denkenz@gmail.com> writes:
> =

>> You will never be able to
>> hit any sort of power consumption targets with CLCC polling anyway.
> =

> I think we do still have another possible line of investigation here.
> Neil Brown reported that the modem does generate NO CARRIER on one of
> its serial ports - just not the one that is expected.  So perhaps that
> can be understood and used, and then the CLCC polling could be switched
> off.

That would certainly help the situation some, but CLCC polling can not
be completely turned off.  The 'generic' 27.007 based voicecall driver
in oFono was written to minimize polling if possible.  The underlying
assumption is that a 'NO CARRIER' is sent whenever a call (held /
active) is disconnected.  The other times we need to poll are limited,
usually after an action we have taken (e.g. CHLD) or certain call
detection situations.

The only times we need to poll periodically is to detect state
transitions when a call is not under 'our control'.  E.g. dialing ->
alerting, alerting -> active, waiting -> disconnected, dialing /
alerting -> disconnected, etc.

> =

> Denis, I looked at the oFono code to try to see where CLCC polling is
> enabled for an active call, and in fact I couldn't see (in
> plugins/atmodem/voicecall.c, which I think is the relevant code) what
> could cause oFono _not_ to do CLCC polling.  It looks unconditional
> there - is that right?

This particular chunk causes it to poll unconditionally (the
OFONO_VENDOR_QUALCOMM_MSM is set by the hso modem driver):

                switch (vd->vendor) {
                case OFONO_VENDOR_QUALCOMM_MSM:
                        poll_again =3D TRUE;
                        break;

This was added by Marcel because the 'NO CARRIER' notification never
came.  See commit 9e26e29f.  If someone can fix this by e.g. using a
slave GAtChat with the additional magical unsolicited notification tty,
then that quirk can be removed.

Regards,
-Denis

--===============0571173062688006334==--

