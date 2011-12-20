Content-Type: multipart/mixed; boundary="===============5144316732491895919=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 2/3] network: Add CPHS SPN, short-SPN fallbacks
Date: Tue, 20 Dec 2011 00:34:25 -0600
Message-ID: <4EF02C71.7020008@gmail.com>
In-Reply-To: <4EEF34F9.9050503@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5144316732491895919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 12/19/2011 06:58 AM, Oleg Zhurakivskyy wrote:
> Hello Denis,
> =

> On 12/17/2011 02:54 AM, Denis Kenzior wrote:
>> I went ahead and applied this patch, but modified it heavily afterward.
>>   Can you please check the changes starting at 7f18695f and make sure
>> that things are still working as intended and I didn't screw anything up.
> =

> Everything works as expected, thanks for the help!
> =

> I just wonder now about the case when the SPN update would happen while
> the NETWORK_REGISTRATION_FLAG_READING_SPN is on.
> =


This is possible if extremely unlikely.  However, the nasty part is that
we probably would need to take care of other cases besides SPN...

> diff --git a/src/network.c b/src/network.c
> struct ofono_netreg {
> [...]
>         char *spn;
> +       unsigned int spn_update;
>  };
> [...]
> =

> +static gboolean spn_update_cb(gpointer userdata)
> +{
> +       struct ofono_netreg *netreg =3D userdata;
> +
> +       if (netreg->flags & NETWORK_REGISTRATION_FLAG_READING_SPN)
> +               return TRUE;
> +
> +       netreg->spn_update =3D 0;
> +
> +       sim_spn_changed(0, netreg);
> +
> +       return FALSE;
> +}
> +
>  static void sim_spn_changed(int id, void *userdata)
>  {
>         struct ofono_netreg *netreg =3D userdata;
>         gboolean had_spn;
> =

> -       if (netreg->flags & NETWORK_REGISTRATION_FLAG_READING_SPN)
> +       if (netreg->flags & NETWORK_REGISTRATION_FLAG_READING_SPN) {
> +               if (netreg->spn_update =3D=3D 0)
> +                       netreg->spn_update =3D g_timeout_add(1000,
> +                                                       spn_update_cb,
> netreg);
> +
>                 return;
> +       }
> [...]
> =

> What do you think?

You have to be careful here since you can't really guarantee that the
operation will succeed in your time allotted.  If you are unlucky the
timer will fire before the entire transaction succeeds and you might be
running the old transaction and the new transaction in parallel.  You
would have to check if the current code can handle this, but probably
not.  And of course you never know what timer value is large enough.

A better approach might be to set another flag in this case, e.g.
RECHECK_SPN, and re-do the transaction.  However, you'd also need to
make sure the sim file cache is flushed as well.

> =

> I will be sending SPN changes for src/gprs.c soon.

Before you do this, a sanity check on whether any MVNOs actually use the
CPHS SPN field might be in order.  It may be that this complexity is not
needed in the gprs.c provisioning logic; and that the EFspn field is
sufficient.

Regards,
-Denis

--===============5144316732491895919==--

