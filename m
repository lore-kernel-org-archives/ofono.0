Content-Type: multipart/mixed; boundary="===============6087800961211760523=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] voicecall: add ofono_voicecall_en_list_notify api
Date: Fri, 25 Mar 2011 12:44:25 -0500
Message-ID: <4D8CD479.307@gmail.com>
In-Reply-To: <1301062083-20416-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6087800961211760523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 03/25/2011 09:08 AM, Jeevaka Badrappan wrote:
> ---
>  include/voicecall.h |    3 +++

Please break this up into two patches.

>  src/voicecall.c     |   12 ++++++++++++
>  2 files changed, 15 insertions(+), 0 deletions(-)
> =


<snip>

> +void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
> +					GSList *new_en_list)
> +{
> +	GSList *l;
> +
> +	for (l =3D new_en_list; l; l =3D l->next)
> +		vc->new_en_list =3D g_slist_prepend(vc->new_en_list,
> +							g_strdup(l->data));

The pure 27.007 version of this function assumes that the en set is
being signaled by the cell tower.  This set needs to be union-ed with
the set obtained from the sim.

Likely you will need to track the sim list separately from the one
obtained from the cell tower and remove any duplicates.

> +
> +	set_new_ecc(vc);
> +}
> +
>  int ofono_voicecall_driver_register(const struct ofono_voicecall_driver =
*d)
>  {
>  	DBG("driver: %p, name: %s", d, d->name);

Regards,
-Denis

--===============6087800961211760523==--

