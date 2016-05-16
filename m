Content-Type: multipart/mixed; boundary="===============3944069916013836071=="
MIME-Version: 1.0
From: Zhang, Caiwen <caiwen.zhang@intel.com>
Subject: RE: [PATCH] plugins/ril: complete modem power off process
Date: Mon, 16 May 2016 06:41:05 +0000
Message-ID: <DA62CA5DDF4CA640AA25B1684E5D1411020B3AF5@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <5736861F.6000504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3944069916013836071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,

> > ---
> >   plugins/ril.c | 19 +++++++++++++++++--
> >   1 file changed, 17 insertions(+), 2 deletions(-)
> >
> =

> I went ahead and applied this patch, however, see below:
> =

> > diff --git a/plugins/ril.c b/plugins/ril.c index 2298bb6..2ea3fb5
> > 100644
> > --- a/plugins/ril.c
> > +++ b/plugins/ril.c
> > @@ -409,15 +409,30 @@ int ril_enable(struct ofono_modem *modem)
> >   	return -EINPROGRESS;
> >   }
> >
> > +static void power_off_cb(struct ril_msg *message, gpointer user_data)
> > +{
> > +	struct cb_data *cbd =3D user_data;
> > +	struct ril_data *rd =3D cbd->user;
> > +	struct ofono_modem *modem =3D cbd->data;
> > +
> > +	if (rd) {
> > +		g_ril_unref(rd->ril);
> =

> It seems GRil doesn't gracefully handle g_ril_unrefs from within a result
> callback.  Have you tried running this with valgrind?
> =

> We might need to come up with a fix for GRil...
> =


The g_ril_unref should be fine. There are two glib runtime warning messages=
, it is because:
In handle_response/gril.c: handle_response, after " req->callback" is calle=
d, "gril" has been cleaned up,
both 'out_queue' and 'command_queue' are NULL.

It seems it's harmless. I will submit a patch to avoid the warnings.


> > +		rd->ril =3D NULL;
> > +	}
> > +
> > +	ofono_modem_set_powered(modem, FALSE); }
> > +
> >   int ril_disable(struct ofono_modem *modem)
> >   {
> >   	struct ril_data *rd =3D ofono_modem_get_data(modem);
> > +	struct cb_data *cbd =3D cb_data_new(NULL, modem, rd);
> >
> >   	DBG("%p", modem);
> >
> > -	ril_send_power(rd, FALSE, NULL, NULL);
> > +	ril_send_power(rd, FALSE, power_off_cb, cbd);

Regards,
Caiwen

--===============3944069916013836071==--

