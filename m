Content-Type: multipart/mixed; boundary="===============7009035724463418456=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] isimodem/voicecall: fix hangup_active
Date: Wed, 06 Oct 2010 11:34:05 +0200
Message-ID: <1286357645.6145.27.camel@aeonflux>
In-Reply-To: <1286356981-29522-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7009035724463418456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  drivers/isimodem/voicecall.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
> index 4b720be..ace2346 100644
> --- a/drivers/isimodem/voicecall.c
> +++ b/drivers/isimodem/voicecall.c
> @@ -988,11 +988,11 @@ static void isi_answer(struct ofono_voicecall *ovc,
>  	isi_call_answer_req(ovc, CALL_ID_ALL, cb, data);
>  }
>  =

> -static void isi_hangup(struct ofono_voicecall *ovc,
> +static void isi_hangup_active(struct ofono_voicecall *ovc,
>  			ofono_voicecall_cb_t cb, void *data)
>  {
>  	/* AT+CHUP */
> -	isi_call_release_req(ovc, CALL_ID_ALL, CALL_CAUSE_TYPE_CLIENT,
> +	isi_call_release_req(ovc, CALL_ID_ACTIVE, CALL_CAUSE_TYPE_CLIENT,
>  				CALL_CAUSE_RELEASE_BY_USER, cb, data);

while at it, you might also wanna remove the reference to an AT command.
Seems like a copy&past leftover from the original atmodem driver.

Regards

Marcel



--===============7009035724463418456==--

