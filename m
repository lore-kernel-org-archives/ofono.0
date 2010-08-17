Content-Type: multipart/mixed; boundary="===============2734821246010165772=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Removal of modemconf plugin
Date: Tue, 17 Aug 2010 18:08:49 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A47328F28F73@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1282038865.23399.65.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2734821246010165772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Marcel Holtmann
>Sent: Tuesday, August 17, 2010 5:54 PM
>To: ofono(a)ofono.org
>Subject: RE: Removal of modemconf plugin
>
>Hi Caiwen,
>
>a gentle reminder that this mailing list doesn't allow top posting,
>please follow the netiquette for open source mailing lists.
>
>> What about dual mode modems that with two different serial ports?
>> e.g. a modem support both GSM and CDMA, there is a serial port
>> For GSM, and there is a serial another for CDMA.
>>
>>
>> Why not keep both udev and modemconf plug-in. It remains for the user
>> To decide which way to use. I think maybe we can change the compile
>> Scrips, let user to select which plug-in to use.
>
>I don't even see a problem with this at all. Every serial port is
>present in udev, so you can write proper udev rules for it. A modem with
>a serial port for GSM and another one CDMA will be just presented as two
>modems inside oFono. So no problem at all.
>
>So modemconf plugin will be removed since it is not needed at all. The
>only component that needs it is the phonesim plugin. And that will get
>its own configuration file.

Can we just add some code in phonesim to make it look like a pseudo serial =
device which can be managed by udev? That is, if we start the phonesim, it =
will simulate some tty ports under /dev and udevd will inform the oFono the=
re is a new device (We need some rule for phonesim). And the device disappe=
ars if phonesim meets an end.
Maybe this is possible if we can send message to udevd the same way as kern=
el via netlink.

>
>Regards
>
>Marcel
>



Regards,
-Yang

--===============2734821246010165772==--

