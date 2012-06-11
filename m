Content-Type: multipart/mixed; boundary="===============2153009066223509938=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: Implement signal strength polling in plugin/driver
Date: Mon, 11 Jun 2012 16:00:23 +0200
Message-ID: <4FD5F9F7.4010005@linux.intel.com>
In-Reply-To: <d9e9c17c27aa80d12803dbaa87b8b971@toulouse.viveris.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2153009066223509938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Audric,

On 07/06/2012 17:20, Audric Schiltknecht wrote:
> Hi guys,
>
> It seems my first post was lost, so here is a new try.
>
> I am currently developing an ofono-based GSM control interface, using =

> a Sagem
> Hilo modem (I wrote the appropriate plugin) with the atmodem driver.
>
> I am having trouble with signal strength reporting. The terminal does =

> not report
> signal strength by event. Hence, it is not possible to get the value =

> from Ofono,
> since Ofono expects it to be updated on a +CIEV event. I implemented a
> new DBus method in the NetworkRegistration interface to force AT+CSQ =

> command and
> update the property value, but this is clearly not a valid solution.

Do you know in modem specifications if Sagem is using a specific signal =

strength notifications command?
If yes, then you should update in drivers/atmodem/network-registration.c =

the at_creg_set_cb() function to handle OFONO_VENDOR_SAGEM case.
Thus you can use register to the good comman notification.

Could you also give us your AT log and more particulary the =

"AT+CMER=3D3,0,0,1" answer?
Maybe, this configuration is not supported by your modem and you should =

change it.

>
> I found by looking in include/netreg.h that it should be up to the =

> plugin to
> implement CSQ polling, however I can't find how it is supposed to be =

> done.
> Indeed, the plugin has no access to the netreg atom nor structure, so =

> how is it
> supposed to update one of these properties ?

Indeed, if you use it for instance with ConnMan signal strength =

notification won't work or maybe I miss something.

Kind regards,
Guillaume


--===============2153009066223509938==--

