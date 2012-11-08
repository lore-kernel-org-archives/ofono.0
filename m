Content-Type: multipart/mixed; boundary="===============5001605760706974692=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Alcatel Onetouch X515 support
Date: Thu, 08 Nov 2012 08:16:43 -0600
Message-ID: <509BBECB.80809@gmail.com>
In-Reply-To: <CABvLYuB1FDRiL7n3u3XmDqRpKz8z5j0PxnXH00MPfEMeY3dc=w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5001605760706974692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 11/08/2012 04:12 AM, Cedric Jehasse wrote:
> Hi,
>
> I'm looking to extend the alcatel plugin to be able to setup a pdp
> context with an Alcatel dongle.
>
> The first issue i ran into is right after entering the pin, "AT+CPIN?"
> is returning a CME Error: SIM busy. And the PinRequired property is not
> updated.
> I have taken logs with the software from Alcatel, and in those logs i
> see "AT+CNUM" and "AT+CSCA?" also return the same error.
> I think we can get these errors while the sim is initializing.
>
> It looks like AT+CPIN? should be polled on this device. I wanted to do
> this from the alcatel plugin, but I don't know how to update the sim
> state from there to change Pinrequired.
> It would be done automatically if i would call __ofono_sim_recheck_pin
> from the plugin, but i'm not sure if it can be called from a plugin.
>
> Do you have any advice for me on this?
>

Check how other plugins do this, in particular pay attention to =

at_util_sim_state_query usage.

Regards,
-Denis

--===============5001605760706974692==--

