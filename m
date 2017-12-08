Content-Type: multipart/mixed; boundary="===============0912307989891558828=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Don't submit parallel EFpl reads
Date: Fri, 08 Dec 2017 10:23:55 -0600
Message-ID: <819df3d2-b4ab-7a84-43d2-9e0949a673ac@gmail.com>
In-Reply-To: <1512745076-3153-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0912307989891558828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 12/08/2017 08:57 AM, Slava Monich wrote:
> In addition to not doing unnecessary SIM I/O, this fixes memory leaks
> like this one:
> =

> =3D=3D10096=3D=3D 74 (56 direct, 18 indirect) bytes in 2 blocks are defin=
itely lost in loss record 1,252 of 1,342
> =3D=3D10096=3D=3D    at 0x4841BF0: calloc (vg_replace_malloc.c)
> =3D=3D10096=3D=3D    by 0x4B03117: g_malloc0 (gmem.c)
> =3D=3D10096=3D=3D    by 0xF83DF: concat_lang_prefs (sim.c)
> =3D=3D10096=3D=3D    by 0xF8697: sim_efpl_read_cb (sim.c)
> =3D=3D10096=3D=3D    by 0x12CBF7: sim_fs_op_read_block_cb (simfs.c)
> ---
>   src/sim.c | 3 +++
>   1 file changed, 3 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============0912307989891558828==--

