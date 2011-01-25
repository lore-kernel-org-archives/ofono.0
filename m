Content-Type: multipart/mixed; boundary="===============1305887692013378958=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Don't use c++ keyword in public header files
Date: Tue, 25 Jan 2011 12:54:24 +0100
Message-ID: <1295956464.1520.24.camel@aeonflux>
In-Reply-To: <1295956032-27028-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1305887692013378958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

>  include/sim.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 81df60e..6e93769 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -154,7 +154,7 @@ struct ofono_sim_driver {
>  			ofono_sim_lock_unlock_cb_t cb, void *data);
>  	void (*change_passwd)(struct ofono_sim *sim,
>  			enum ofono_sim_password_type type,
> -			const char *old, const char *new,
> +			const char *p_old, const char *p_new,
>  			ofono_sim_lock_unlock_cb_t cb, void *data);
>  	void (*lock)(struct ofono_sim *sim, enum ofono_sim_password_type type,
>  			int enable, const char *passwd,

why is this exactly a problem?

And if you really wanna do that, then please not something cryptic like
p_new. Names like new_passwd or new_pw are way more descriptive.

Another possibility is using the combination current + passwd.

Regards

Marcel



--===============1305887692013378958==--

