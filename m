Content-Type: multipart/mixed; boundary="===============3179548659121971445=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Add sim driver call for applications discovery.
Date: Thu, 13 Jan 2011 10:39:09 -0600
Message-ID: <4D2F2AAD.8030208@gmail.com>
In-Reply-To: <1294834365-11029-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3179548659121971445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 01/12/2011 06:12 AM, Andrzej Zaborowski wrote:
> ---
>  include/sim.h |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index aab981c..e4176e3 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -77,6 +77,12 @@ enum ofono_sim_state {
>  	OFONO_SIM_STATE_READY,
>  };
>  =

> +struct ofono_sim_app_record {
> +	unsigned char aid[16];
> +	unsigned int aid_len;
> +	char *label;
> +};
> +
>  typedef void (*ofono_sim_file_info_cb_t)(const struct ofono_error *error,
>  					int filelength,
>  					enum ofono_sim_file_structure structure,
> @@ -114,6 +120,9 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const stru=
ct ofono_error *error,
>  typedef void (*ofono_sim_locked_cb_t)(const struct ofono_error *error,
>  					int locked, void *data);
>  =

> +typedef void (*ofono_sim_apps_cb_t)(const struct ofono_error *error,
> +					GSList *apps, void *data);
> +

Please remember that we do not use G* types in the ofono public API.

>  typedef void (*ofono_sim_file_notify_t)(int id, void *userdata);
>  =

>  struct ofono_sim_driver {
> @@ -159,6 +168,8 @@ struct ofono_sim_driver {
>  	void (*query_locked)(struct ofono_sim *sim,
>  			enum ofono_sim_password_type type,
>  			ofono_sim_locked_cb_t cb, void *data);
> +	void (*list_apps)(struct ofono_sim *sim, ofono_sim_apps_cb_t cb,
> +			void *data);
>  };

Do you think this belongs on a separate atom?  E.g. something like
Pekka's SimAuthentication ?

>  =

>  int ofono_sim_driver_register(const struct ofono_sim_driver *d);

Regards,
-Denis

--===============3179548659121971445==--

