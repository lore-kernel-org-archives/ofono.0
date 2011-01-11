Content-Type: multipart/mixed; boundary="===============0650210525472739161=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 3/4] sim: add ofono_sim_get_mnc_length
Date: Mon, 10 Jan 2011 16:40:42 -0800
Message-ID: <1294706442.3873.9.camel@aeonflux>
In-Reply-To: <1294665072-13630-4-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0650210525472739161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

>  include/sim.h |    1 +
>  src/sim.c     |    8 ++++++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 7860e24..9b21f2e 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -173,6 +173,7 @@ void ofono_sim_set_data(struct ofono_sim *sim, void *=
data);
>  void *ofono_sim_get_data(struct ofono_sim *sim);
>  =

>  const char *ofono_sim_get_imsi(struct ofono_sim *sim);
> +unsigned int ofono_sim_get_mnc_length(struct ofono_sim *sim);

so here is now the question. Do we wanna make this simple and do it like
this or just provide functions to the MCC and MNC like we do inside the
network registration interface?

Denis, any favorites?

Regards

Marcel



--===============0650210525472739161==--

