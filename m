Content-Type: multipart/mixed; boundary="===============0530053251991140541=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/5] simfs: retrieve only EF-info without EF-contents
Date: Fri, 22 Oct 2010 12:19:46 -0500
Message-ID: <4CC1C7B2.5000506@gmail.com>
In-Reply-To: <1287673093-3022-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0530053251991140541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 10/21/2010 09:58 AM, Petteri Tikander wrote:
> ---
>  include/sim.h |    5 ++++
>  src/simfs.c   |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++--
>  src/simfs.h   |    4 +++
>  3 files changed, 70 insertions(+), 3 deletions(-)

I applied this patch but did some evil amending, see my comments below:

> =

> diff --git a/include/sim.h b/include/sim.h
> index 7860e24..15e1ea0 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -102,6 +102,11 @@ typedef void (*ofono_sim_file_read_cb_t)(int ok, int=
 total_length, int record,
>  					const unsigned char *data,
>  					int record_length, void *userdata);
>  =

> +typedef void (*ofono_sim_fs_read_info_cb_t)(int ok,
> +					unsigned char file_status,
> +					int total_length,
> +					int record_length, void *userdata);
> +

I actually wanted this completely out of the public API and limited to
simfs.h.  The reason is that only sim.c will be accessing this one, so
no need to expose it to the rest of the system.

> -	if (!imsi)
> +	if (!imsi || !op->info_only)

This introduced a bug with the caching which I had to fix separately.

Regards,
-Denis

--===============0530053251991140541==--

