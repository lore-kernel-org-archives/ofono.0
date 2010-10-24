Content-Type: multipart/mixed; boundary="===============2505937270111202651=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simfs: Fix issue with sim_fs_op_error
Date: Sun, 24 Oct 2010 09:13:47 -0500
Message-ID: <4CC43F1B.5000907@gmail.com>
In-Reply-To: <1287921843-18631-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2505937270111202651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 10/24/2010 07:04 AM, Jeevaka Badrappan wrote:
> ---
>  src/simfs.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> =

> diff --git a/src/simfs.c b/src/simfs.c
> index 4204aca..1e71f82 100644
> --- a/src/simfs.c
> +++ b/src/simfs.c
> @@ -142,7 +142,10 @@ static void sim_fs_op_error(struct sim_fs *fs)
>  {
>  	struct sim_fs_op *op =3D g_queue_peek_head(fs->op_q);
>  =

> -	if (op->is_read =3D=3D TRUE)
> +	if (op->info_only =3D=3D TRUE)
> +		((sim_fs_read_info_cb_t) op->cb)
> +			(0, 0, 0, 0, op->userdata);
> +	else if (op->is_read =3D=3D TRUE)
>  		((ofono_sim_file_read_cb_t) op->cb)
>  			(0, 0, 0, 0, 0, op->userdata);
>  	else

Good catch.  Patch has been applied, thanks.

Regards,
-Denis

--===============2505937270111202651==--

