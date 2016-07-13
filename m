Content-Type: multipart/mixed; boundary="===============2532745127214276331=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: designated way for modems disappearing from bus during +CFUN=1
Date: Wed, 13 Jul 2016 12:09:31 -0500
Message-ID: <578675CB.5020604@gmail.com>
In-Reply-To: <20160711173751.GD5250@nataraja>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2532745127214276331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Harald,

On 07/11/2016 12:37 PM, Harald Welte wrote:
> Dear all,
>
> I've been struggling for quite some time to find out what is the
> designated way in ofono to deal with modems that actually perform a
> cold/warm reset (and hence USB device stack reset) when you send them an
> AT+CFUN=3D1 message.

The best way to deal with this is not to have the modem reset :)  Does =

Sierra Wireless have any extensions to turn off this behavior?

>
> Examples for this are e.g. the Sierra Wireless SL808x series of modems,
> where this behavior is documented and expected.  But I'm sure there are
> others, at least I recall having seen this several times in the past.

Generally this isn't done by the modems.  Some will physically power off =

when you send them a CFUN=3D0.  Then you'd need to replug the USB cable.

>
> It is somewhat logical, as a +CFUN+1 is supposed to reset _all_ of the
> status in the modem, not just the protocol stack. So the fact that most
> modems don't disappear from the bus afterwards actually means that they
> are cheating.

No, it means they are sane.  Many modem manufacturers use a second =

parameter to CFUN, which tells the modem whether to reset or not.  E.g. =

CFUN=3D1,1 to cause a full reset.

>
> The actual behavior of ofono with such a modem is:
>
> * modem first appears as a /wavecom_X device
> * if you issue enable_modem via dbus, the modem goes thrugh CFUN=3D1
> * the modem disappears from USB, ofono destroys its structures
> * the client program (e.g. the one from tests/) simply hangs and fails
>    at timeout
> * the modem re-enumerates on the bus and ofono creates a new /wavecom_Y
>    device, where Y !=3D the X before the modem restart.
>
> So for an application it is not possible to continue to talk to one
> modem via dbus accross modem resets.
>
> Not issuing a +CFUN=3D1 is also not really an option, as then you loose
> the ability to completely disable the modem.  +CFUN=3D4 can be used to
> force an IMSI detach and disable it from the network point of view, but
> the modem is still talking to the SIM card and will not re-read SIM
> card state if brought back online from +CFUN=3D4.

I know of no USB based device that provides a complete power down =

setting.  Some (like Ericsson) just jump off the USB bus when a CFUN=3D0 =

is issued, but it doesn't really help, as you'd need to physically take =

the modem out and plug it back in.  Hence we just go back to CFUN=3D4 mode =

on disable for these devices.

Since most of these devices need to be pulled out in order to change the =

SIM card, it is generally not a problem.

>
> I'm sure this issue has been seen before, and somebody must have a
> solution for it - or at least some ideas on how to solve this in a ofono
> driver plugin.  I'm willing to spend some time on it, but my
> experience/exposure to the code base is limited.

This is just a limitation of USB devices.  If you want proper control of =

a modem power state, you might want to research devices with =

full-featured modems on board.

Regards,
-Denis

--===============2532745127214276331==--

