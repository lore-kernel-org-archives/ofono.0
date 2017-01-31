Content-Type: multipart/mixed; boundary="===============4327565865644187971=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Telit modem plugins.
Date: Mon, 30 Jan 2017 23:33:13 -0600
Message-ID: <080dd8a5-3a4d-8f28-9a0e-05eff9c2bb41@gmail.com>
In-Reply-To: <a64abdef-9c38-440b-5932-7cee53b67560@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4327565865644187971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Piotr,

On 01/30/2017 07:02 AM, Piotr Haber wrote:
> Hi.
> Seems my rename of he910 plugin to xe910 was a little bit optimistic.
> Looks like not only xE910 family modems use 1bc7:0021 USB IDs.
>
> I got my hands on UE866 and it has the same default composition.
> So this is another family, designed for embedded M2M/IoT applications
> with different module form-factor, but having similar members (GE866 2G,
> UE866 3.5G, LE866 4G)
> And according to documentation UL865 should share the same USB IDs.
> And as UL865 is an UMTS enabled, pin-compatible upgrade to GL865-DUAl V3
> I would expect the latter will also have the same composition.
> I could not find a definitive source of information on this.
>

Don't think I ever played with the UL865 line.  The original telit =

plugin was written for the UC864 housed on the EVK2 board.  That is why =

that particular plugin is using usbserial driver.  At some point someone =

added additional driver/usbid combinations.

Telit maintains a similar command set across all of their devices, so =

things must have just worked.  At some point they switched to Intel =

chips (HE910 and LE910 must be anyway).

> So it seems the plugin needs a different name, again.
> There is already "telit" plugin but this one supports modems based on
> "option" serial ports and USB PIDs starting from 0x1003, this includes
> CE/DE/LE910 (LE910 V1 that is, using QMI, which is end-of-life),
> HE/LE920 and LE922/LE940A6.

Can we unify xe910 and telit.c?  Don't think there's a huge difference =

between them either.  telit.c has some Bluetooth SAP support stuff in =

it, but honestly I don't see anyone using it, so it won't be a big loss =

if that code was dropped on the floor.

>
> Do you have any suggestions on the new name for this plugin?
> I would go for something like "telit-acm" (cause it uses CDC-ACM serial
> ports).
>

If the two can't be unified, perhaps rename telit -> telit_sap and xe910 =

-> telit?

Regards,
-Denis


--===============4327565865644187971==--

