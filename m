Content-Type: multipart/mixed; boundary="===============5386724926241154613=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Connecting a phone with mpty call does not trigger CLCC
 polling
Date: Wed, 27 May 2015 09:19:42 -0500
Message-ID: <5565D27E.30806@gmail.com>
In-Reply-To: <1431945524-6781-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5386724926241154613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 05/18/2015 05:38 AM, Kuba Pawlak wrote:
> If there is more then one active or held call, we are in mpty calls.
> We won't get indicator update if any of them is released by CHLD=3D1x.
> So we have to poll it.
> ---
>   drivers/hfpmodem/voicecall.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>

I took another look at this one, a few minor issues:

> diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
> index afeb35f..5d044a9 100644
> --- a/drivers/hfpmodem/voicecall.c
> +++ b/drivers/hfpmodem/voicecall.c
> @@ -1134,6 +1134,10 @@ static void hfp_clcc_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>   	struct ofono_voicecall *vc =3D user_data;
>   	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
>   	unsigned int mpty_ids;
> +	GSList *n;
> +	struct ofono_call *nc;
> +	unsigned int num_active =3D 0;
> +	unsigned int num_held =3D 0;
>
>   	if (!ok)
>   		return;
> @@ -1142,6 +1146,22 @@ static void hfp_clcc_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>
>   	g_slist_foreach(vd->calls, voicecall_notify, vc);
>   	ofono_voicecall_mpty_hint(vc, mpty_ids);
> +
> +	n =3D vd->calls;
> +
> +	while (n) {
> +		nc =3D n ? n->data : NULL;

Why are you checking for n ? here.  Isn't while (n) above enough?

> +		if (nc && (nc->status =3D=3D CALL_STATUS_ACTIVE))
> +			num_active++;

parentheses around nc->status =3D=3D ... are not necessary.

Also, n->data should never be NULL.  If it is, I rather crash early.

So just checking for nc->status is sufficient.

e.g.

while (n) {
	nc =3D n->data;

	switch (nc->status) {
	case CALL_STATUS_ACTIVE:
		...
	case CALL_STATUS_HELD:
		...
	default:
		break;
	}
}

> +
> +		if (nc && (nc->status =3D=3D CALL_STATUS_HELD))
> +			num_held++;
> +
> +		n =3D n->next;
> +	}
> +
> +	if ((num_active > 1 || num_held > 1) && !vd->clcc_source)
> +		vd->clcc_source =3D g_timeout_add(POLL_CLCC_INTERVAL, poll_clcc, vc);
>   }
>
>   static void hfp_voicecall_initialized(gboolean ok, GAtResult *result,
>

Regards,
-Denis

--===============5386724926241154613==--

