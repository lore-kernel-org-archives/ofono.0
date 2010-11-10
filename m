Content-Type: multipart/mixed; boundary="===============9142512910631944082=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/4] isigen: make number of PDP contexts configurable
Date: Thu, 11 Nov 2010 02:52:37 +0900
Message-ID: <1289411557.9615.271.camel@aeonflux>
In-Reply-To: <1289391751-2844-5-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9142512910631944082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

>  plugins/isigen.c |   23 +++++++++++++++++------
>  plugins/udev.c   |    6 +++++-
>  2 files changed, 22 insertions(+), 7 deletions(-)

<snip>
 =

> @@ -434,6 +434,10 @@ static void add_isi(struct ofono_modem *modem,
>  	if (addr !=3D NULL)
>  		ofono_modem_set_integer(modem, "Address", atoi(addr));
>  =

> +	pdps =3D get_property(udev_device, "OFONO_ISI_PDPS");
> +	if (pdps !=3D NULL)
> +		ofono_modem_set_integer(modem, "PDPS", atoi(pdps));
> +
>  	if (g_strcmp0(udev_device_get_subsystem(udev_device), "net") !=3D 0)
>  		return;

why to do you bother making this a configurable option? What isthe
benefit here?

Personally I think that always enabling 4 context if the hardware
supports it should be enough. If you do support more then just enable
more all the time. There are no real resources used in context of ISI
anyway. The AT command based modems have a different problem since for
most of them we need an extra TTY/DLC and an extra GAtChat object, but
ISI does not have that problem.

Regards

Marcel



--===============9142512910631944082==--

