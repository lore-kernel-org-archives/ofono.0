Content-Type: multipart/mixed; boundary="===============2025008913207916060=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] sim: add ofono_sim_get_spn API header
Date: Thu, 27 Jan 2011 14:56:23 +0100
Message-ID: <1296136583.1520.155.camel@aeonflux>
In-Reply-To: <1296134537-16133-2-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2025008913207916060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

>  include/sim.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 5e3ba5b..7e573fd 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -180,6 +180,8 @@ void *ofono_sim_get_data(struct ofono_sim *sim);
>  const char *ofono_sim_get_imsi(struct ofono_sim *sim);
>  const char *ofono_sim_get_mcc(struct ofono_sim *sim);
>  const char *ofono_sim_get_mnc(struct ofono_sim *sim);
> +const char *ofono_sim_get_spn(struct ofono_sim *sim);
> +unsigned char ofono_sim_get_spn_dc(struct ofono_sim *sim);

what is the spn_dc for? We are converting everything into UTF-8 anyway
and that should be sufficient.

Regards

Marcel



--===============2025008913207916060==--

