Content-Type: multipart/mixed; boundary="===============6850224586708385494=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 2/3] sim800: add documentation.
Date: Wed, 07 Nov 2018 14:50:22 +0100
Message-ID: <7808bb11-d16f-4189-d4a0-76d861e40fd3@norrbonn.se>
In-Reply-To: <1541585670-3551-2-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6850224586708385494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clement,

On 07/11/2018 11:14, Clement Viel wrote:
> ---
>   doc/sim800-modem.txt | 7 +++++++
>   1 file changed, 7 insertions(+)
>   create mode 100644 doc/sim800-modem.txt
> =

> diff --git a/doc/sim800-modem.txt b/doc/sim800-modem.txt
> new file mode 100644
> index 0000000..a299e97
> --- /dev/null
> +++ b/doc/sim800-modem.txt
> @@ -0,0 +1,7 @@
> +SIM800 modem usage
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To enable SIM800 module support you need to put the following
> +udev rule into appropriate file in /{etc,lib}/udev/rules.d:
> +
> +KERNEL=3D=3D"ttyS0", ENV{OFONO_DRIVER}=3D"sim800"
> =


Confused by this.  Isn't the sim900 the serial modem and sim800 the USB =

model?  The above rule is for a strictly "serial" modem.

/Jonas

--===============6850224586708385494==--

