Content-Type: multipart/mixed; boundary="===============5931377745023606424=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 20:30:53 +0200
Message-ID: <CAKSBH7HNpY9Zn98SKC+m83z-Bq_i5NM5D+TXj-L7odyJZ5UPcg@mail.gmail.com>
In-Reply-To: <a37c6461-1132-ebbf-08c8-05f6c46e941d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5931377745023606424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Oct 12, 2018 at 8:10 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >   static void at_lte_set_default_attach_info(const struct ofono_lte *lt=
e,
> >                       const struct ofono_lte_default_attach_info *info,
> >                       ofono_lte_cb_t cb, void *data)
> >   {
> >       struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
> >       char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
> > -     struct cb_data *cbd =3D cb_data_new(cb, data);
> > +     struct lte_callbackdata *cbd =3D g_new0(struct lte_callbackdata ,=
1);
> > +     const char *proto;
> > +     size_t len;
> >
> > +     cbd->cb =3D cb;
> > +     cbd->data =3D data;
> > +     cbd->ldd =3D ldd;
>
> You can't really do that.  There's no guarantee that the core atom will
> keep this object around for the lifetime of the driver transaction.

That's interesting. Can I pass const struct ofono_lte *lte, or the
same constraints apply?
Or some other object that I can rely upon?
Also, the core atom shouldn't be called until the callback is triggered.

> Why do you need this anyway?  Is it just to build the +CGAUTH part?  Why
> don't you l_strdup_printf the +CGAUTH commmand or something instead and
> invoke it in the callback?
>
> E.g. cbd =3D cb_data_new();
> char *cgauth_cmd =3D g_strdup_printf("CGAUTH=3D0,1,"%s","%s", username,
> password);

I will check this, also for compatibility with the switch(vendor) to
come, but I have to confess
I don't really like building the command somewhere and using it later.
It is unexpected for someone reading the code.
What if I have to chain more commands?

>
> cbd->user =3D cgauth_cmd;
>
> Alternatively you can queue both commands and save the +CGAUTH command
> id inside ldd.  Then if +CGDCONT fails, you can g_at_chat_cancel the
> +CGAUTH.

this possibility is also interesting, but equally confusing: I pipe
two commands, and later remove one,
if someone follows the code up to this function, the removal might go unnot=
iced.

>
> > +     cbd->info =3D info;
> > +
> > +     switch (info->proto) {
> > +     case OFONO_GPRS_PROTO_IPV6:
> > +             proto =3D "IPV6";
> > +             break;
> > +     case OFONO_GPRS_PROTO_IPV4V6:
> > +             proto =3D "IPV4V6";
> > +             break;
> > +     case OFONO_GPRS_PROTO_IP:
> > +             proto =3D "IP";
> > +             break;
> > +     }
> > +
> > +     len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"%s\"", proto=
);
> > +
> > +     if (*info->apn)
> > +             snprintf(buf+len, sizeof(buf)-len, ",\"%s\"", info->apn);
> >
> > -     /* We can't do much in case of failure so don't check response. */
> >       if (g_at_chat_send(ldd->chat, buf, NULL,
> > -                     at_lte_set_default_attach_info_cb, cbd, g_free) >=
 0)
> > +                     at_lte_set_default_attach_info_cb, cbd, NULL) > 0)
>
> Why are you removing the destructor.  This will cause leaks whenever a
> hot-unplug event happens and this command is queued...
>
> If you want to use cbd across multiple commands, the proper way to do
> that is with a reference counted structure.

is there an example elsewhere in the code?

>
> >               return;
> >
> > +     g_free(cbd);
> >       CALLBACK_WITH_FAILURE(cb, data);
> >   }
> >
> >
>
> Regards,
> -Denis

Regards,
Giacinto

--===============5931377745023606424==--

