Content-Type: multipart/mixed; boundary="===============2997898136766689134=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 7/8] sim: getters for mcc and mnc implementation
Date: Tue, 18 Jan 2011 15:44:52 +0100
Message-ID: <1295361892.3873.187.camel@aeonflux>
In-Reply-To: <1295338172-12773-8-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2997898136766689134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

>  src/sim.c |   50 +++++++++++++++++++++++++++++++-------------------
>  1 files changed, 31 insertions(+), 19 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index d627647..86c3f13 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -78,6 +78,8 @@ struct ofono_sim {
>  	gboolean barred_dialing;
>  =

>  	char *imsi;
> +	char mcc[OFONO_MAX_MCC_LENGTH + 1];
> +	char mnc[OFONO_MAX_MNC_LENGTH + 1];

so I would split this a little bit.

1) refactor src/sim.c to store mcc and mnc.
2) add header definitions
3) add getters implementation.

And send these separately. No need to make them part of the provision
patch set. I know that you need them for that, but they are not really
required and could be reviewed and applied quicker.

Regards

Marcel



--===============2997898136766689134==--

