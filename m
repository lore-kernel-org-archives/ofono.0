Content-Type: multipart/mixed; boundary="===============6374033245330619672=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 1/4] Add: support for EF_ICCID in isimodem.
Date: Wed, 26 May 2010 00:27:45 +0300
Message-ID: <1274822865.3755.467.camel@tucson.research.nokia.com>
In-Reply-To: <1274819827-27993-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6374033245330619672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On Tue, 2010-05-25 at 22:37 +0200, Pessi Pekka (Nokia-D/Helsinki) wrote:
> ---
>  drivers/isimodem/sim.c |  180 +++++++++++++++++++++++++++---------------=
-----
>  drivers/isimodem/sim.h |    1 +
>  2 files changed, 104 insertions(+), 77 deletions(-)
> =

> diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
> index 6cf73d2..6f2607b 100644
> --- a/drivers/isimodem/sim.c
> +++ b/drivers/isimodem/sim.c
> @@ -45,20 +45,25 @@
>  =

>  struct sim_data {
>  	GIsiClient *client;
> -	bool iccid;
>  	bool registered;
>  };
>  =

> -/* Returns fake (static) file info for EFSPN */
> -static gboolean efspn_file_info(gpointer user)
> +struct file_info {
> +	int fileid, length, structure, record_length;

These should be on separate lines.

But I fixed that and a couple of other nitpicks, and pushed all four
patches.

Thanks!

Cheers,
Aki


--===============6374033245330619672==--

