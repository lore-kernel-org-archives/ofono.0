Content-Type: multipart/mixed; boundary="===============2167634618259758217=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] modem: Make it possible to identify the physical device
 of the modem
Date: Thu, 01 Nov 2012 04:49:37 -0500
Message-ID: <509245B1.5000804@gmail.com>
In-Reply-To: <1351766368-30075-1-git-send-email-holger@freyther.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2167634618259758217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

On 11/01/2012 05:39 AM, Holger Hans Peter Freyther wrote:
> From: Holger Hans Peter Freyther<hfreyther@sysmocom.de>
>
> The naming of modems might not reflect the physical order of devices.
> E.g. /dev/ttyUSB0 might end up as /wavecom_3 and /dev/ttyUSB2 might be
> /wavecom_1. Add a 'Device' property to be able to identify the port.
>

Aren't your devices serial port based and detected via udev rules? =

Anyway, I can understand the need here but...

> An application can then use sysfs to identify the bus and device to
> rebuild the physical order. This way we can map the modem path to the
> port number on our modem bank.
> ---
>   doc/modem-api.txt |    5 +++++
>   src/modem.c       |    6 ++++++
>   2 files changed, 11 insertions(+)
>
> diff --git a/doc/modem-api.txt b/doc/modem-api.txt
> index 1c4e440..68e719e 100644
> --- a/doc/modem-api.txt
> +++ b/doc/modem-api.txt
> @@ -168,3 +168,8 @@ Properties	boolean Powered [readwrite]
>   			supported by this modem.
>
>   			Possible values are "hfp", "sap" and "hardware".
> +
> +		string Device [readonly, optional]
> +
> +			The physical device the modem is connected to. This
> +			can be used to identify the physical port of the modem.

I really do not think exposing the device name is a good idea.  First of =

all, no normal application can make use of it anyway.  Once the modem is =

powered on oFono takes exclusive rights to it.  Secondly, most USB =

sticks are actually multi-device groupings anyway, so this property =

really makes no sense.

Why don't you simply assign a name to the modem using =

ofono_modem_set_name.  This can be done by assigning the name directly =

in the udev rule and having the necessary magic inside plugins/udev.c. =

The name can be anything you wish in that case.

Regards,
-Denis

--===============2167634618259758217==--

