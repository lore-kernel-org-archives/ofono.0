Content-Type: multipart/mixed; boundary="===============3296660725693414117=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono support for the Telit GC864-QUAD V2 serial port GSM/GPRS
 modem
Date: Wed, 17 Oct 2012 08:34:21 -0500
Message-ID: <507EB3DD.4000307@gmail.com>
In-Reply-To: <20121017112852.GA32058@macbook.imko>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3296660725693414117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On 10/17/2012 06:28 AM, Markus Hubig wrote:
> Hello @all,
>
> I'm new here and I'm in the process of developing a Embedded Linux datalo=
gger
> appliance. At the moment I'm evaluating the modem part of it, and we are
> looking forward to use the Telit GC864-QUAD V2 serial port GSM/GPRS modem=
 with
> oFono.
>
> Unfortunately I couldn't find much "getting started" information for oFon=
o, but
> by reading throughout the old posts on this list I gathered at least some.
> Please correct me if I get things wrong:
>
> 1. The one-and-only way to tell oFono to use a modem is by udev rules like
>     this:
>
>      KERNEL=3D=3D"ttyUSB0", ENV{OFONO_DRIVER}=3D"calypso"

Not the 'only' way, but that is the preferred way.  The KERNEL=3D=3D line =

tells udev the device to use and OFONO_DRIVER part tells what modem =

driver to use (e.g. one from plugins/)

>
> 2. Serial port GPRS modems like the Telit GC864 are not supported
>     out-of-the-box, so one has to write a special modem driver for it.

We do not have a 'generic' driver.  While it is tempting to think that =

27.007 is enough to drive any modem, in practice that is not the case. =

At least we have tried and failed ;)  So yes, your statement is correct.

>
> 3. Since this modem supports CMUX multiplexing with the 3GPP 27.010 stand=
ard,
>     I can use 'GAtMux' like it's done in 'plugins/calypso.c'.

Correct.

>
> 4. There is a telit modem driver, but this is only for the UC864 UMTS mod=
em
>     which is connected via USB.

Correct.

>
> So in order to write a driver to support the GC864, what would be a good
> starting point? Add support for serial port CMUX to the telit driver?
>

I would create a brand new modem driver, perhaps using calypso as the =

starting point and go from there.

> Looking forward for some advice ...
>

IRC is also a good place to get (quick) questions answered.

Regards,
-Denis

--===============3296660725693414117==--

