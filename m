Content-Type: multipart/mixed; boundary="===============9114765175200853962=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] radio-settings: Fix memory leaks in radio_load_settings
Date: Fri, 02 Jun 2017 10:43:44 -0500
Message-ID: <a343cd8c-41f4-fdf7-c64b-3118a593e0ef@gmail.com>
In-Reply-To: <1496418064-7713-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9114765175200853962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 06/02/2017 10:41 AM, Slava Monich wrote:
> Errors returned by g_key_file_get_integer have to be deallocated
> by the caller to avoid leaks like these:
>
> =3D=3D13330=3D=3D 104 (24 direct, 80 indirect) bytes in 2 blocks are defi=
nitely lost
> =3D=3D13330=3D=3D    at 0x483F3EC: malloc (vg_replace_malloc.c)
> =3D=3D13330=3D=3D    by 0x4B020DF: g_malloc (gmem.c)
> =3D=3D13330=3D=3D    by 0x4B17F51: g_slice_alloc (gslice.c)
> =3D=3D13330=3D=3D    by 0x4AE80B9: g_error_new_valist (gerror.c)
> =3D=3D13330=3D=3D    by 0x4AE830B: g_set_error (gerror.c)
> =3D=3D13330=3D=3D    by 0x4AF5681: g_key_file_get_value (gkeyfile.c)
> =3D=3D13330=3D=3D    by 0x4AF6817: g_key_file_get_integer (gkeyfile.c)
> =3D=3D13330=3D=3D    by 0x10CFE3: radio_load_settings (radio-settings.c)
> =3D=3D13330=3D=3D    by 0x10D2E3: ofono_radio_settings_register (radio-se=
ttings.c)
> ---
>  src/radio-settings.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>

Applied, thanks.

Regards,
-Denis

--===============9114765175200853962==--

