Content-Type: multipart/mixed; boundary="===============7653860648745719327=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Motorola Modem H24 gprs connection
Date: Thu, 31 Mar 2011 10:42:06 -0500
Message-ID: <4D94A0CE.3020804@gmail.com>
In-Reply-To: <65D0035E6914AC478A46CFE3E20C3926017CC3F9@snch1xch53.sicpa-net.ads>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7653860648745719327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 03/31/2011 09:00 AM, Ostermann, Christophe wrote:
> Hi,
> =

>  =

> =

> After having successfully enabled sms and voice call with modem h24 from
> motorola. I am now trying to setup a gprs connection.
> =

> In fact Motorola has a specific set of AT command AT+MIPxxx to setup
> gprs connection by using an internal TCP/UDP IP stack.

Not quite sure what that means?  Do you mean the modem expects raw data
and produces TCP/IP packets internally?  If so you will have some fun ;)

> =

> Can you confirm that the right approach is to write a new gprs-context.c ?
> =

>  =


Yes.

> =

> When a gprs cantext has properly established connection, does ofono
> create a network interface?
> =

>  =


No, a network interface is either already created by the kernel driver
when the device is inserted (e.g. on usb data sticks from hso, mbm, etc)
or created by the ppp stack managed inside the gprs-context driver.  All
oFono does is bring the interface up.

Regards,
-Denis

--===============7653860648745719327==--

