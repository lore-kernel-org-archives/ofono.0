Content-Type: multipart/mixed; boundary="===============0069074324750977810=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: read phonebook
Date: Sun, 12 Jun 2016 11:56:35 +0200
Message-ID: <d3809766-1c5e-1529-0d6e-bd118900495c@chini.tk>
In-Reply-To: <27e92148-3e07-af40-5893-03d2bb07a0e2@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0069074324750977810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12.06.2016 11:23, Marco Trapanese wrote:
>
> Hello Georg, hello Jason!
> Thank you both for your interesting answers.
> As far as I understand obex is now integrated in bluez5:
>
>> https://packages.debian.org/jessie/bluez-obexd
>
>> http://www.bluez.org/page/7/
>
> (see Release of BlueZ 5.0)
>
>> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/obex-api.txt
>
>
> Thus my confusion about the test script in ofono!
> So, if I'm running off-topic, I will move to the bluez mailing-list.
>
> Anyway, following the hints of Jason I exported the dbus session =

> address (because I don't use X) and set the dbus policies in =

> bluetooth.conf. I paired and trusted my phone.
>
> Running the bluez/test/pbap-client script or the Georg's code leads to:
>
>> dbus.exceptions.DBusException: =

>> org.freedesktop.DBus.Error.ServiceUnknown: The name org.bluez.obex =

>> was not provided by any .service files
>
> while the ofono/test/test-phonebook returns:
>
>> dbus.exceptions.DBusException: =

>> org.freedesktop.DBus.Error.UnknownMethod: Method "Import" with =

>> signature "" on interface "org.ofono.Phonebook" doesn't exist
>
> Because obex is under org.bluez I don't think I need the obexd-client =

> Debian package, do I?
I have bluez-obexd installed.

--===============0069074324750977810==--

