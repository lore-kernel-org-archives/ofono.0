Content-Type: multipart/mixed; boundary="===============5147439798697740386=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v3 11/16] elect: Dis/Connect Serial interface
Date: Wed, 14 Dec 2011 18:56:13 -0600
Message-ID: <4EE945AD.4020907@gmail.com>
In-Reply-To: <1323788410-9988-12-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5147439798697740386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 12/13/2011 09:00 AM, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> =

> ---
>  elect/device.c |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 122 insertions(+), 2 deletions(-)
> =


Just taking a very cursory initial look:

<snip>

> +	status =3D bluetooth_send_with_reply(device->path,
> +					BLUEZ_SERIAL_INTERFACE, "Connect",
> +					&call, bt_connect_reply,
> +					device, NULL, DBUS_TIMEOUT,
> +					DBUS_TYPE_STRING, &profile,
> +					DBUS_TYPE_INVALID);

I still say you don't want to use the RFCOMM tty layer.  You should
probably use ConnectFD instead.

Also, the details of establishing a transport connection should ideally
be abstracted away and implemented in plugins.  That way you can easily
add bluetooth and usb, as well as whatever makes things easier for
testing, e.g. tcp or evel local pseudo-ttys.

Regards,
-Denis

--===============5147439798697740386==--

