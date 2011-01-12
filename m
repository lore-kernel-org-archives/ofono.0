Content-Type: multipart/mixed; boundary="===============8052563492978916761=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] sim: Cache flushing functions.
Date: Wed, 12 Jan 2011 14:09:33 -0600
Message-ID: <4D2E0A7D.6080505@gmail.com>
In-Reply-To: <1294657295-14041-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8052563492978916761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 01/10/2011 05:01 AM, Andrzej Zaborowski wrote:
> ---
>  src/sim.c   |   23 ++++++++++++++++++++
>  src/simfs.c |   68 ++++++++++++++++++++++++++++++++++++++++++++---------=
-----
>  src/simfs.h |    5 ++++
>  3 files changed, 79 insertions(+), 17 deletions(-)
> =


So I applied this patch but...:

> +
> +static void sim_file_changed_flush(struct ofono_sim *sim, int id)
> +{
> +	int i, imgid;
> +
> +	if (id =3D=3D SIM_EFIMG_FILEID)
> +		/* All cached images become invalid */
> +		sim_fs_image_cache_flush(sim->simfs);
> +	else if (sim->efimg)
> +		/*
> +		 * Data and CLUT for image instances stored in the changed
> +		 * file need to be re-read.
> +		 */
> +		for (i =3D sim->efimg_length / 9 - 1; i >=3D 0; i--) {
> +			imgid =3D (sim->efimg[i * 9 + 3] << 8) |
> +				sim->efimg[i * 9 + 4];
> +
> +			if (imgid =3D=3D id)
> +				sim_fs_image_cache_flush_file(sim->simfs, i);
> +		}
> +
> +	sim_fs_cache_flush_file(sim->simfs, id);
> +}

This function seems extraneous to this patch.  I assumed that it was
meant to be included in patch 4 and I left it out.

Regards,
-Denis

--===============8052563492978916761==--

