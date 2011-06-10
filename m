Content-Type: multipart/mixed; boundary="===============8760780333460946040=="
MIME-Version: 1.0
From: Bernhard Guillon <Bernhard.Guillon@hale.at>
Subject: Re: [PATCH v4 4/4] udev: add Telit UC864-G and update udev rules
Date: Fri, 10 Jun 2011 10:32:10 +0200
Message-ID: <alpine.DEB.2.00.1106100958000.30119@entw48>
In-Reply-To: <4DED61F8.6090608@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8760780333460946040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On Mon, 6 Jun 2011, Denis Kenzior wrote:

>> I was not able to hard code the interface number as novatel does it
>> because the interfaces change on different telit modems. I used the
>> huawai code as base.
>
> So let me understand what you're trying to achieve, you want to set an
> environment variable telling the driver that a particular model has a
> GPS port?

Yes.

>
> From what I remember of the Telit modems, all ports are fully
> functional, so the GPS port can be on any tty.  If this is the case,
> then the way this can be accomplished is by querying the model /
> revision of the modem during the enable() stage in the modem driver and
> adding the appropriate atom as needed.
>

The GPS port is not fully functional as far is I know it is read only. =

According to the manual it is necessary to enable over the modem line =

with AT$GPSP=3D1 afterwards it starts reporting NMEA signals on the GPS =

line.

I like the environment setting with udev more. The approach with querying =

the model during enable() requires a update to the telit plugin every time =

a new model with gps is released. The comment about hardcode the interface =

number was an answer to the suggestion to look at the novatel udev code. =

Sorry for mixing up things.

After I dug deeper into the add_modem code I don't know if I have a =

problem at all :)

My current "problem" with the patch I sent is that I get into the

 	if (modem =3D=3D NULL) {
 		const char *serial =3D get_serial(parent);

 		modem =3D ofono_modem_create(serial, driver);

case.

ofonod[16327]: src/modem.c:ofono_modem_create() name: 000000000002, type: =

telit

So my modem dbus modem path is /000000000002 which I thought it was wrong.
Everything else works well. The GPS value is set and both paths are set =

right.

So I think my real question is - is it the intended behavior to have the =

path like this? I don't have any supported modem to test (I really should =

by one :D ) and the phonesim is using /phonesim1 as path

Best regards,
Bernhard


--
Scanned by MailScanner.


--===============8760780333460946040==--

