Content-Type: multipart/mixed; boundary="===============1894917475094519438=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] udev: udpate udev to detect new 7xxx modems
Date: Wed, 31 Oct 2018 07:59:02 +0100
Message-ID: <CAKSBH7GRHZv3E8uL0kSPatEfggDOQ5CMA7trKzxn_Wnv=Nj3Lg@mail.gmail.com>
In-Reply-To: <1540968962-14314-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1894917475094519438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2018 at 7:54 AM Nandini Rebello
<nandini.rebello@intel.com> wrote:
>
> Newer intel modems enumerate with different subsystem numbers,
> adding code to detect newer 7xxx modules.
>
> Plan to add patch for backward compatibility of intels modems soon,
> to based on interface number instead of subsystem name string.
> ---
>  plugins/udevng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 11338f7..bf0b1c4 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1194,10 +1194,10 @@ static gboolean setup_xmm7xxx(struct modem_info *=
modem)
>                                 info->sysattr, info->subsystem);
>
>                 if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> -                       if (g_strcmp0(info->number, "02") =3D=3D 0)
> +                       if (g_strcmp0(info->number, "00") =3D=3D 0)

but then all current users of the models using the usb device 02 (and
00 below) will be cut off if they update to this patch.
Maybe you need to add the switching logic you mentioned above based on
interface number in the same patch.

>                                 mdm =3D info->devnode;
>                 } else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
> -                       if (g_strcmp0(info->number, "00") =3D=3D 0)
> +                       if (g_strcmp0(info->number, "06") =3D=3D 0)
>                                 net =3D info->devnode;
>                 }
>         }
> --
> 2.7.4
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

regards,
Giacinto

--===============1894917475094519438==--

