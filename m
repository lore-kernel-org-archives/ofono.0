Content-Type: multipart/mixed; boundary="===============5340532295556811189=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] sim800: adding documentation to inform about the udev
 rule the user must add
Date: Wed, 19 Sep 2018 11:43:49 -0500
Message-ID: <bc5638ae-f6f3-2a2a-9af2-3d9bf0405a3e@gmail.com>
In-Reply-To: <1537302987-12592-3-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5340532295556811189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/18/2018 03:36 PM, Cl=C3=A9mentViel wrote:
> From: clem <vielclement@gmail.com>

Can you fix your Author information (see AUTHORS for an example). =

Otherwise I cannot take these...

> =

> ---
>   doc/sim800-modem.txt | 7 +++++++
>   1 file changed, 7 insertions(+)
>   create mode 100644 doc/sim800-modem.txt
> =

> diff --git a/doc/sim800-modem.txt b/doc/sim800-modem.txt
> new file mode 100644
> index 0000000..6731879
> --- /dev/null
> +++ b/doc/sim800-modem.txt
> @@ -0,0 +1,7 @@
> +SIM800 modem usage
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To enable SIM900 module support you need to put the following
> +udev rule into appropriate file in /{etc,lib}/udev/rules.d:
> +
> +KERNEL=3D=3D"ttyUSB0", ENV{OFONO_DRIVER}=3D"sim800"
> =


So sim800 is a serial device right?  I take it you're running it from a =

serial converter here?

Regards,
-Denis

--===============5340532295556811189==--

