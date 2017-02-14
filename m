Content-Type: multipart/mixed; boundary="===============0809627722019644562=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei E3372
Date: Tue, 14 Feb 2017 09:47:11 -0600
Message-ID: <a81bb17d-4b7e-e272-91ae-045b2f032500@gmail.com>
In-Reply-To: <088d60e2-4e2c-c7d0-47ab-0022de446b14@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0809627722019644562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

> usb 1-1: New USB device found, idVendor=3D12d1, idProduct=3D15b7
 > Using ATI, modem present itself like that:
 >
 > Manufacturer: huawei
 > Model: E3372H
 > Revision: 21.315.01.00.314
 > IMEI: XXXX
 > +GCAP: +CGSM,+DS,+ES
 >
 > My problem now is how to know if I should send AT+CGDATA=3D"PPP",1 or
 > ATD*99***1# when activating context in at modem driver. I see in this
 > driver and others that a VENDOR information can be sent from plugin but
 > I imagine that other Huawei devices support AT+CGDATA=3D"PPP",1.
 >
 > Do you have any idea of what I should do to support this modem without
 > disturbing other devices?

You could build a database of various quirks that are required for each =

model.  The index into the database could be the product id if it is =

unique, or the model / revision information from 'ATI"

Another idea would be to have the gprs context driver try to parse the =

AT+CGDATA=3D? response.  If 'PPP' L2P is not found, then fallback to using =

ATD*99.

Regards,
-Denis

--===============0809627722019644562==--

