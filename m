Content-Type: multipart/mixed; boundary="===============6624209642752847591=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCHv2 1/4] sim: add ofono_sim_get_mnc_length
Date: Mon, 03 Jan 2011 12:37:03 -0800
Message-ID: <1294087023.5852.16.camel@aeonflux>
In-Reply-To: <1294039912-6008-2-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6624209642752847591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

>  include/sim.h |    1 +
>  src/sim.c     |    8 ++++++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 7860e24..3d0c6b7 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -173,6 +173,7 @@ void ofono_sim_set_data(struct ofono_sim *sim, void *=
data);
>  void *ofono_sim_get_data(struct ofono_sim *sim);
>  =

>  const char *ofono_sim_get_imsi(struct ofono_sim *sim);
> +int ofono_sim_get_mnc_length(struct ofono_sim *sim);

actually that value is an unsigned char.

Regards

Marcel



--===============6624209642752847591==--

