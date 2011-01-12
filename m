Content-Type: multipart/mixed; boundary="===============1509253786836497485=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] ctm: add ofono_ctm_get_modem interface
Date: Tue, 11 Jan 2011 21:59:41 -0800
Message-ID: <1294811981.3873.50.camel@aeonflux>
In-Reply-To: <1294674900-10256-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1509253786836497485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>  include/ctm.h |    2 ++
>  src/ctm.c     |    5 +++++
>  2 files changed, 7 insertions(+), 0 deletions(-)
> =

> diff --git a/include/ctm.h b/include/ctm.h
> index 5305469..71e3d61 100644
> --- a/include/ctm.h
> +++ b/include/ctm.h
> @@ -59,6 +59,8 @@ void ofono_ctm_remove(struct ofono_ctm *ctm);
>  void ofono_ctm_set_data(struct ofono_ctm *ctm, void *data);
>  void *ofono_ctm_get_data(struct ofono_ctm *ctm);
>  =

> +struct ofono_modem *ofono_ctm_get_modem(struct ofono_ctm *ctm);
> +

in principle this is fine, but I wait for the result of the audio
discussion to see if we really need this.

Regards

Marcel



--===============1509253786836497485==--

