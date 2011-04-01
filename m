Content-Type: multipart/mixed; boundary="===============8574076434016123744=="
MIME-Version: 1.0
From: Ostermann, Christophe <Christophe.Ostermann@sicpa.com>
Subject: RE: Motorola Modem H24 gprs connection
Date: Fri, 01 Apr 2011 09:00:14 +0200
Message-ID: <65D0035E6914AC478A46CFE3E20C3926017CC3FA@snch1xch53.sicpa-net.ads>
In-Reply-To: <4D94A0CE.3020804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8574076434016123744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thank you for this quick answer.

Yes H24 modem expects some raw data in this mode (after having created a
TCP or UDP socket). =


This modem must also support standard way of sending data through ppp. I
will start by using this mode. I ve tried but unfortunately AT+CGDATA is
not recognized by this modem. I m just starting to play with this modem
so I ve to investigate how to configure it properly without this
command.

BR
Christophe



-----Original Message-----
From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Sent: jeudi, 31. mars 2011 17:42
To: ofono(a)ofono.org
Cc: Ostermann, Christophe
Subject: Re: Motorola Modem H24 gprs connection

Hi Christophe,

On 03/31/2011 09:00 AM, Ostermann, Christophe wrote:
> Hi,
> =

>  =

> =

> After having successfully enabled sms and voice call with modem h24
from
> motorola. I am now trying to setup a gprs connection.
> =

> In fact Motorola has a specific set of AT command AT+MIPxxx to setup
> gprs connection by using an internal TCP/UDP IP stack.

Not quite sure what that means?  Do you mean the modem expects raw data
and produces TCP/IP packets internally?  If so you will have some fun ;)

> =

> Can you confirm that the right approach is to write a new
gprs-context.c ?
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
This message was delivered through encrypted mechanism.


The information in this email and any attachments is confidential
and intended solely for the use of the individual(s) to whom it is
addressed or otherwise directed.
Please note that any views or opinions presented in this email are
solely those of the author and do not necessarily represent those
of the Company.
Finally, the recipient should check this email and any attachments
for the presence of viruses.
The Company accepts no liability for any damage caused by any virus
transmitted by this email.

--===============8574076434016123744==--

