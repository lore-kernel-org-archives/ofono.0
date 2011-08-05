Content-Type: multipart/mixed; boundary="===============8972947757687268738=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gatppp: save dumpfile into ppp info to start
 recording during open phase.
Date: Fri, 05 Aug 2011 08:26:24 -0500
Message-ID: <4E3BEF80.2040504@gmail.com>
In-Reply-To: <1312533244-28622-2-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8972947757687268738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 08/05/2011 03:34 AM, Bertrand Aygon wrote:
> ---
>  gatchat/gatppp.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> =

> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index 2ff6c86..47a4949 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -85,6 +85,7 @@ struct _GAtPPP {
>  	gboolean suspended;
>  	gboolean xmit_acfc;
>  	gboolean xmit_pfc;
> +	gchar *dumpfile;
>  };
>  =

>  void ppp_debug(GAtPPP *ppp, const char *str)
> @@ -541,6 +542,8 @@ gboolean g_at_ppp_open(GAtPPP *ppp, GAtIO *io)
>  	if (ppp->hdlc =3D=3D NULL)
>  		return FALSE;
>  =

> +	g_at_hdlc_set_recording(ppp->hdlc, ppp->dumpfile);
> +
>  	ppp->suspended =3D FALSE;
>  	g_at_hdlc_set_receive(ppp->hdlc, ppp_receive, ppp);
>  	g_at_hdlc_set_suspend_function(ppp->hdlc,
> @@ -593,7 +596,11 @@ void g_at_ppp_set_recording(GAtPPP *ppp, const char =
*filename)
>  	if (ppp =3D=3D NULL)
>  		return;
>  =

> -	g_at_hdlc_set_recording(ppp->hdlc, filename);
> +	g_free(ppp->dumpfile);
> +
> +	ppp->dumpfile =3D g_strdup(filename);
> +
> +	g_at_hdlc_set_recording(ppp->hdlc, ppp->dumpfile);

I'm failing to see the point in making this change.  Why do you need to
save the dump filename inside gatppp?

>  }
>  =

>  void g_at_ppp_set_connect_function(GAtPPP *ppp, GAtPPPConnectFunc func,
> @@ -745,6 +752,8 @@ void g_at_ppp_unref(GAtPPP *ppp)
>  =

>  	g_at_hdlc_unref(ppp->hdlc);
>  =

> +	g_free(ppp->dumpfile);
> +
>  	g_free(ppp);
>  }
>  =


Regards,
-Denis

--===============8972947757687268738==--

