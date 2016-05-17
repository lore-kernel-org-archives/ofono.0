Content-Type: multipart/mixed; boundary="===============8084961715834058174=="
MIME-Version: 1.0
From: Zhang, Caiwen <caiwen.zhang@intel.com>
Subject: RE: [PATCH] avoid glib runtime warning
Date: Tue, 17 May 2016 03:24:47 +0000
Message-ID: <DA62CA5DDF4CA640AA25B1684E5D1411020B3DB9@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <5739EB85.1090908@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8084961715834058174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >
> > diff --git a/gril/gril.c b/gril/gril.c index 297a772..34cadbb 100644
> > --- a/gril/gril.c
> > +++ b/gril/gril.c
> > @@ -374,7 +374,10 @@ static void handle_response(struct ril_s *p, struct
> ril_msg *message)
> >   			if (req->callback)
> >   				req->callback(message, req->user_data);
> >
> =

> Can we simply return if p->destroyed is set to true instead?
> =


Done. =


Please have look.

> > -			len =3D g_queue_get_length(p->out_queue);
> > +			if (p->out_queue)
> > +				len =3D g_queue_get_length(p->out_queue);
> > +			else
> > +				len =3D 0;
> >
> >   			for (i =3D 0; i < len; i++) {
> >   				id =3D GPOINTER_TO_INT(g_queue_peek_nth( @@
> -387,8 +390,10 @@
> > static void handle_response(struct ril_s *p, struct ril_msg *message)
> >
> >   			ril_request_destroy(req);
> >
> > -			if (g_queue_peek_head(p->command_queue))
> > -				ril_wakeup_writer(p);
> > +			if (p->command_queue) {
> > +				if (g_queue_peek_head(p->command_queue))
> > +					ril_wakeup_writer(p);
> > +			}
> >
> >   			break;
> >   		}
> >
> =


Thanks,
Caiwen

--===============8084961715834058174==--

