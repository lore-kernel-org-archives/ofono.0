Content-Type: multipart/mixed; boundary="===============1637865881088111338=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] huawei: cleanup sim polling when the modem is removed.
Date: Wed, 03 Aug 2011 10:59:46 +0100
Message-ID: <568DE01DA537804BA73470071BAC28893900696C@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1312365045.3373.4.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1637865881088111338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> >  plugins/huawei.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/plugins/huawei.c b/plugins/huawei.c
> > index 1380369..eaf8b07 100644
> > --- a/plugins/huawei.c
> > +++ b/plugins/huawei.c
> > @@ -107,6 +107,9 @@ static void huawei_remove(struct ofono_modem
> *modem)
> >  	/* Cleanup after hot-unplug */
> >  	g_at_chat_unref(data->pcui);
> >
> > +	if (data->sysinfo_poll_source)
> > +		g_source_remove(data->sysinfo_poll_source);
> > +
> >  	g_free(data);
> >  }
> =

> so actually you do not wanna do this in the remove callback. You wanna
> do this in the disable callback just before you cancel all pending
> commands.

Ok, but it will not fix the crash I have saw and that conclude to this fix.=
 If we unplug the modem during the init, we go directly to remove_modem, an=
d not going through disable_modem.

So maybe we have to put this in both places.

> Doing this in the remove callback has the potential problem that you
> might poll CPIN while trying to execute CFUN. In theory this does not
> matter since GAtChat will not execute commands at the same time, but
> why
> bother keeping the timeout running if we already know that we are going
> to shutdown the device.
> =

> We call disable before we call remove, but the only thing that I have
> not checked is what happens to this if we have not succeeded with
> enable
> yet. So if I remember this right, then disable is always called (even
> if
> enable has not yet called set_powered), but I need Denis to confirm
> this.

Except in the unplug test.

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============1637865881088111338==--

