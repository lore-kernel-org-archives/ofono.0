Content-Type: multipart/mixed; boundary="===============8352369202130576574=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 7/9] ofono-rules: Add cdmagen device
Date: Sat, 18 Dec 2010 19:31:05 +0100
Message-ID: <1292697065.2658.14.camel@aeonflux>
In-Reply-To: <1292627481-9109-8-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8352369202130576574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

>  plugins/ofono.rules |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index da8a8ef..34698f0 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -429,6 +429,10 @@ ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"=
1311", ENV{OFONO_DRIVER}=3D"mbm"
>  # Nokia Internet Stick CS-10
>  ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"060e", ENV{OFONO_DRI=
VER}=3D"nokia"
>  =

> +# Nokia CDMA Device
> +ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"023e", ENV{OFONO_DRI=
VER}=3D"cdmagen"
> +ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b6", ENV{OFONO_DRI=
VER}=3D"cdmagen"
> +

since this is Nokia specific device, then using nokiacdma would be a
better name. Or using OFONO_DRIVER=3Dnokia NOKIA_MODE=3Dcdma and sharing the
driver might be useful.

It really all depends how much they have in common. So what kind of
hardware is this actually? A phone or a real USB dongle?

Regards

Marcel



--===============8352369202130576574==--

