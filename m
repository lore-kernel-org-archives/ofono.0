Content-Type: multipart/mixed; boundary="===============5206985233224017568=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 6/8] sim: add function for reading only general info
 from SIM-EF file
Date: Fri, 15 Oct 2010 07:32:16 -0500
Message-ID: <4CB849D0.8080201@gmail.com>
In-Reply-To: <1287090175-3018-7-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5206985233224017568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 10/14/2010 04:02 PM, Petteri Tikander wrote:
> Not actual EF-contents returned, but file length, record length, file sta=
tus etc.
> ---
>  include/sim.h |   10 ++++++++++
>  src/sim.c     |   21 +++++++++++++++++++--
>  2 files changed, 29 insertions(+), 2 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 7860e24..8dd6131 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -207,6 +207,16 @@ int ofono_sim_write(struct ofono_sim *sim, int id,
>  int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
>  			unsigned short offset, unsigned short num_bytes,
>  			ofono_sim_file_read_cb_t cb, void *data);
> +
> +/*
> + * This function reads only general info from SIM-file with
> + * requested id (file length, record length, file status etc),
> + * not any records.
> + */
> +int ofono_sim_read_info(struct ofono_sim *sim, int id,
> +			enum ofono_sim_file_structure expected,
> +			ofono_sim_file_read_cb_t cb, void *data);
> +

This function is only needed by the sim atom, so I personally would
prefer to keep this API out from include/sim.h.  Let us just introduce
sim_fs_read_info() instead.  I also want a dedicated callback typedef
for this, e.g.:
typedef void (*sim_fs_read_info_cb_t)(int ok, unsigned char file_status,
					int total_length,
					int record_length,
					void *userdata);

Regards,
-Denis

--===============5206985233224017568==--

