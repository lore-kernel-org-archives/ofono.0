Content-Type: multipart/mixed; boundary="===============2523698335933223985=="
MIME-Version: 1.0
From: Ostermann, Christophe <Christophe.Ostermann@sicpa.com>
Subject: RE: Motorola Modem H24 gprs connection
Date: Mon, 04 Apr 2011 14:14:15 +0200
Message-ID: <65D0035E6914AC478A46CFE3E20C3926017CC401@snch1xch53.sicpa-net.ads>
In-Reply-To: <4D95E1E1.8050901@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2523698335933223985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> =

> Hi Christophe,
> =

> Gentle reminder not to top-post on this mailing list.
> =

> On 04/01/2011 02:00 AM, Ostermann, Christophe wrote:
> > Hi Denis,
> >
> > Thank you for this quick answer.
> >
> > Yes H24 modem expects some raw data in this mode (after having
created a
> > TCP or UDP socket).
> >
> > This modem must also support standard way of sending data through
ppp. I
> > will start by using this mode. I ve tried but unfortunately
AT+CGDATA is
> > not recognized by this modem. I m just starting to play with this
modem
> > so I ve to investigate how to configure it properly without this
> > command.
> >
> =

> You might have luck using the legacy ATD*99 variation instead of
CGDATA,
> but we don't support this inside the current atmodem/gprs-context.c.
> Have a look at gatchat/gsmdial.c, it implements this functionality.
So
> you might be able to quickly test whether PPP/ATD*99 works on the H24.
> =


ATD*99 works fine on H24. How can I pass an option to gprs driver to use
ATD*99 instead of CGDATA ?  based on vendor as in drivers/atmodem/sms.c?


After setting ConnectionContext property "Active" to true I can see that
IPaddr and DNS server addr are properly returned by APN. A ppp0
interface is also available. But ppp0 configuration does not seems to be
correct when I use ifconfig (IP address is not set etc...). Is ofono
responsible of doing this or ppp0 interface must be configured by
another layer?    =


BR,
Christophe
PS: is this email ident style ok ?

> Regards,
> -Denis
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

--===============2523698335933223985==--

