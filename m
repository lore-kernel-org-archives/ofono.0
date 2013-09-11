Content-Type: multipart/mixed; boundary="===============2434424818638873207=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] fix ofonod crash when pin is blocked
Date: Wed, 11 Sep 2013 13:01:10 -0500
Message-ID: <5230AFE6.6050204@gmail.com>
In-Reply-To: <1378919634-5912-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2434424818638873207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 09/11/2013 12:13 PM, caiwen.zhang(a)intel.com wrote:
> From: Caiwen Zhang <caiwen.zhang@intel.com>
>
> When is blocked, gprs/network atom is removed, it will
> remove the SIM SPN watch which is added when it is created.
> If at that time, SIM atom has been removed ofonod will crash
> due to "sim->spn_watches" is NULL.
>

This description makes no sense.  The SIM atom is never removed due to a =

blocked PIN, so can you please provide a more clear description of the =

issue?

> There is the same issue about network registration status watch.
> ---
>   src/watch.c |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/src/watch.c b/src/watch.c
> index dfb01fb..906c559 100644
> --- a/src/watch.c
> +++ b/src/watch.c
> @@ -53,6 +53,9 @@ gboolean __ofono_watchlist_remove_item(struct ofono_wat=
chlist *watchlist,
>   	GSList *p;
>   	GSList *c;
>
> +	if (watchlist =3D=3D NULL)
> +		return;
> +

This fix is wrong, you're likely just covering up the symptom, not the =

cause.  oFono operates on the principle of crash-early, so that bugs are =

easier to detect and find.

What is the real reason why the watchlist is NULL at the point in time =

this function is being called?

>   	p =3D NULL;
>   	c =3D watchlist->items;
>
>

Regards,
-Denis

--===============2434424818638873207==--

