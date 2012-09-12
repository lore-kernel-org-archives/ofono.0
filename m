Content-Type: multipart/mixed; boundary="===============7391490379363332646=="
MIME-Version: 1.0
From: Erik <stimpit@gmail.com>
Subject: Re: Getting started (serial GPRS modem)
Date: Wed, 12 Sep 2012 10:40:37 +0200
Message-ID: <CAK2MJLqFZqRqk8e-PKE9xQU9NuRE8ZpwbnH9tYdW5_wGnwT_rg@mail.gmail.com>
In-Reply-To: <50501458.3050003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7391490379363332646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis!

Thanks a lot for your reply!

On Wed, Sep 12, 2012 at 6:49 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Formal getting started documentation is lacking at the moment. Documentat=
ion contributions are always welcome ;)

I'll write something up if I end up doing something with ofono. I have
no problems sharing code either if I write something using
ofono.

> There are plenty of working examples to learn from however.
>
>> Second, the modem is a serial GPRS modem connected through a serial
>> line. This has to be farily common. Isn't there a simple way of just
>> testing ofono without adding udev rules, writing drivers, etc? What I
>> would like is basically to start ofonod with a path to the serial
>> device, telling it to use only standard (not device-specific) AT command=
s.
>
> We have tried that, unfortunately we have yet to encounter a piece of har=
dware that can be driven entirely using standard AT commands.  There are to=
o many vendor commands and behavioral quirks that have to be accounted for.

Ok. I have only used three different modems altogether. Maybe the reality
is not as good as I thought it was...

>> I don't think what I'd like to do is possible. So I added an udev rule
>> in the form of:
>>
>> KERNEL=3D=3D"ttyUSB*", ENV{OFONO_DRIVER}=3D"nokia"
>
> Are you picking a driver at random or is it indeed a Nokia modem?

I picked a driver at random. What I was looking for was basically to see
if I could at least see some trace of AT commands being sent. I'll care abo=
ut
if they are the right ones when I understand how stuff work. Something
apparently understood that it should use the port I specified. What happens
next? I understand that list-modems ends up doing some dbus magic
in src/manager.c but I haven't really figured out more. Any hints on debugg=
ing
except running ofono with the -d option? Should I be using some dbus
tracing utility? I have no experience *at all* of using dbus myself. i basi=
cally
know more or less what it is but not more than that.

>> Do the existing drivers check that the modem is actually a modem of that
>> type (nokia in this case)?

> No, but the list of modem drivers that support a serial port is only a su=
bset of all the drivers available.  See add_modem() function in plugins/ude=
v.c for more details.  The subset is currently limited to ifx, calypso, tc6=
5, wavecom, sim900 and a few others.  These devices are true serial port de=
vices and frequently require multiplexing, etc.
>>
>> I am not looking for anything fancy. I basically only want to set up a
>> GPRS connection and maybe do operator selection.
>> No voice, no SMS, nothing more.
>
> If you're wanting GPRS on a true serial port based device, then you defin=
itely need to write your own modem driver for it.  GPRS requires multiple A=
T ports to drive successfully which requires multiplexing (e.g. via CMUX). =
 Multiplexing details are frequently vendor-specific, so these have to be h=
andled in your driver.

Hm. I wouldn't say GPRS *requires* multiplexing. I've written a GSM0710 MUX
code before and I know that my current modem supports it (I even made sure
to get the specification for it when we selected this modem) but surely it's
possible to set up a GPRS connection without it, even though such a setup
is quite limited.

I found Android's reference-ril code (not trying to offend anyone, not sure
about any potential religious wars going on here) which seems really
simple. I'll see if that might suit my immediate needs better. But I haven't
written off ofono yet.

I suppose what I'm looking for is a really quick way of doing what I can do
with chat and pppd but with potential of doing much more in the future.

/Erik

--===============7391490379363332646==--

