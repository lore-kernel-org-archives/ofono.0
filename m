Content-Type: multipart/mixed; boundary="===============3742272598190019188=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simfs: Fix reads beyond the first block
Date: Fri, 30 Jul 2021 10:37:44 -0500
Message-ID: <352f49b0-d29b-b43e-3658-9879007773c2@gmail.com>
In-Reply-To: <20210730120751.2682607-1-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3742272598190019188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 7/30/21 7:07 AM, Slava Monich wrote:
> ---
>   src/simfs.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> =


Funny how long this bug has been lurking around.

> diff --git a/src/simfs.c b/src/simfs.c
> index 3d4f6283..cf770265 100644
> --- a/src/simfs.c
> +++ b/src/simfs.c
> @@ -383,18 +383,18 @@ static void sim_fs_op_read_block_cb(const struct of=
ono_error *error,
>   	}
>   =

>   	start_block =3D op->offset / 256;
> -	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
> +	end_block =3D op->num_bytes ? (op->offset + op->num_bytes - 1) / 256 :
> +								start_block;
>   =


Curious why this is needed?  op->num_bytes should never be zero since it ge=
ts =

set to the file length?

Rest looks good to me.

Regards,
-Denis
--===============3742272598190019188==--

