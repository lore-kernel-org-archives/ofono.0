Content-Type: multipart/mixed; boundary="===============0852594606372619089=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH QMI LTE v2 03/13] gprs: release active contexts completely
Date: Fri, 14 Apr 2017 17:13:17 -0500
Message-ID: <b01e87db-02bb-cd2a-88cd-0b8e5f4122cd@gmail.com>
In-Reply-To: <20170414213646.32066-4-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0852594606372619089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/14/2017 04:36 PM, Jonas Bonn wrote:
> The release_active_contexts method ask the driver to deactive all
> the active contexts it knows about; however, after doing so, the
> context state needs to be released, as well, so that the contexts
> do not continue to appear to be active.
> ---
>  src/gprs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/gprs.c b/src/gprs.c
> index 6ed1c89..b6e11e8 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1614,6 +1614,9 @@ static void release_active_contexts(struct ofono_gp=
rs *gprs)
>
>  		if (gc->driver->detach_shutdown !=3D NULL)
>  			gc->driver->detach_shutdown(gc, ctx->context.cid);
> +
> +		pri_reset_context_settings(ctx);
> +		release_context(ctx);

Hmm, this seems wrong.  The original commit (according to git blame, git =

show 05b8fe47) was aimed at PPP contexts.  The gprs_context driver will =

call g_at_ppp_shutdown which in turn will result in eventual =

ppp_disconnect.  The context driver will then call =

ofono_gprs_cid_deactivated.

For the other context drivers, it was assumed that the modem will be =

sane enough to issue a +CGEV with a context deactivation.

I'm assuming you need this for QMI as well, so you might want to use =

similar semantics.  E.g. have detach_shutdown call STOP_NET and then =

call ofono_gprs_cid_deactivated.

>  	}
>  }
>
>

Regards,
-Denis

--===============0852594606372619089==--

