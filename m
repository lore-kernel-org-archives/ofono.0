Content-Type: multipart/mixed; boundary="===============0270180272797503740=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/4] include: add method to query pin Retries
Date: Tue, 04 Jan 2011 11:11:04 -0600
Message-ID: <4D2354A8.6020901@gmail.com>
In-Reply-To: <1294146379-30854-2-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0270180272797503740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 01/04/2011 07:06 AM, Lucas De Marchi wrote:
> ---
>  include/sim.h |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 7860e24..bf4aaf9 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -77,6 +77,11 @@ enum ofono_sim_state {
>  	OFONO_SIM_STATE_READY,
>  };
>  =

> +struct ofono_sim_pin_retry {
> +	enum ofono_sim_password_type id;
> +	int val;
> +};
> +
>  typedef void (*ofono_sim_file_info_cb_t)(const struct ofono_error *error,
>  					int filelength,
>  					enum ofono_sim_file_structure structure,
> @@ -108,6 +113,10 @@ typedef void (*ofono_sim_passwd_cb_t)(const struct o=
fono_error *error,
>  					enum ofono_sim_password_type type,
>  					void *data);
>  =

> +typedef void (*ofono_sim_pin_retries_cb_t)(const struct ofono_error *err=
or,
> +						GSList *pin_retries,

One of the restrictions on the public ofono API is that we cannot use G*
types.  We can solve this in several ways:

- Use an array of ints with the size always being
OFONO_SIM_PASSWORD_INVALID.  The integer value contains the number of
retries or -1 if unknown / unsupported.

- Use an int length, struct ofono_sim_pin_retry *retries elements.  This
is similar to the approach taken in e.g. voicecall ofono_call_list_cb_t
or netreg ofono_netreg_operator_list_cb_t

> +						void *data);
> +
>  typedef void (*ofono_sim_lock_unlock_cb_t)(const struct ofono_error *err=
or,
>  					void *data);
>  =

> @@ -144,6 +153,8 @@ struct ofono_sim_driver {
>  			ofono_sim_passwd_cb_t cb, void *data);
>  	void (*send_passwd)(struct ofono_sim *sim, const char *passwd,
>  			ofono_sim_lock_unlock_cb_t cb, void *data);
> +	void (*query_pin_retries)(struct ofono_sim *sim,
> +				ofono_sim_pin_retries_cb_t cb, void *data);
>  	void (*reset_passwd)(struct ofono_sim *sim, const char *puk,
>  			const char *passwd,
>  			ofono_sim_lock_unlock_cb_t cb, void *data);

Regards,
-Denis

--===============0270180272797503740==--

