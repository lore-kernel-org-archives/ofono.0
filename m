Content-Type: multipart/mixed; boundary="===============5275651244948532070=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: Huawei E3372
Date: Tue, 14 Feb 2017 17:37:38 +0100
Message-ID: <8c2a8072-dbc5-ac84-99a3-8601244f653c@kerlink.fr>
In-Reply-To: <a81bb17d-4b7e-e272-91ae-045b2f032500@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5275651244948532070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,
On 02/14/2017 04:47 PM, Denis Kenzior wrote:
> Hi Christophe,
>
>> usb 1-1: New USB device found, idVendor=3D12d1, idProduct=3D15b7
> > Using ATI, modem present itself like that:
> >
> > Manufacturer: huawei
> > Model: E3372H
> > Revision: 21.315.01.00.314
> > IMEI: XXXX
> > +GCAP: +CGSM,+DS,+ES
> >
> > My problem now is how to know if I should send AT+CGDATA=3D"PPP",1 or
> > ATD*99***1# when activating context in at modem driver. I see in this
> > driver and others that a VENDOR information can be sent from plugin but
> > I imagine that other Huawei devices support AT+CGDATA=3D"PPP",1.
> >
> > Do you have any idea of what I should do to support this modem without
> > disturbing other devices?
>
> You could build a database of various quirks that are required for =

> each model.  The index into the database could be the product id if it =

> is unique, or the model / revision information from 'ATI"
My problem with this idea is that I only have one huawei modem. I have =

no idea what other huawei modems support activation using =

AT+CGDATA=3D"PPP",1, what are their product ids, .... I could say that all =

models except E3372H use this AT command and be quite safe, except if it =

depends on firmware version.
>
> Another idea would be to have the gprs context driver try to parse the =

> AT+CGDATA=3D? response.  If 'PPP' L2P is not found, then fallback to =

> using ATD*99.
I can do that in huawei plugin or in gprs-context atmodem driver.

If I do that in huawei plugin, I need a way to give information to =

gprs-context driver. Maybe using ofono_modem_set_boolean with a property =

like ACTIVATE_CONTEXT_USING_ATD99.
If I do that in gprs-context atmodem driver, this is one step more at =

each context activation but no need to modify all plugins if other =

modems have same behavior.
What do you think is the best way?

Best Regards,

Christophe


--===============5275651244948532070==--

