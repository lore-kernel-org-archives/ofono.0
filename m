Content-Type: multipart/mixed; boundary="===============3796984923477020830=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/6] Add a function to be able to report network
 technology change
Date: Mon, 22 Jul 2013 15:57:49 -0500
Message-ID: <51ED9CCD.1020508@gmail.com>
In-Reply-To: <1374240940-30892-5-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3796984923477020830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On 07/19/2013 08:35 AM, Anthony Viallard wrote:
> When we detect a change of the network technology, ofono don't have
> a function to report this change at higher level (dbus signal, ...)
> ---
>   include/netreg.h | 1 +
>   src/network.c    | 6 ++++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/include/netreg.h b/include/netreg.h
> index 4338c14..94c8e9f 100644
> --- a/include/netreg.h
> +++ b/include/netreg.h
> @@ -91,6 +91,7 @@ struct ofono_netreg_driver {
>   void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int stre=
ngth);
>   void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
>   					int lac, int ci, int tech);
> +void ofono_netreg_tech_notify(struct ofono_netreg *netreg, int tech);

Please don't do this, the tech is already covered by netreg_status_notify

>   void ofono_netreg_time_notify(struct ofono_netreg *netreg,
>   				struct ofono_network_time *info);
>
> diff --git a/src/network.c b/src/network.c
> index d1bfca6..b4cd62f 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -1393,6 +1393,12 @@ void ofono_netreg_status_notify(struct ofono_netre=
g *netreg, int status,
>   	notify_status_watches(netreg);
>   }
>
> +void ofono_netreg_tech_notify(struct ofono_netreg *netreg, int tech)
> +{
> +	if (netreg->technology !=3D tech)
> +		set_registration_technology(netreg, tech);
> +}
> +
>   void ofono_netreg_time_notify(struct ofono_netreg *netreg,
>   				struct ofono_network_time *info)
>   {
>

Regards,
-Denis

--===============3796984923477020830==--

