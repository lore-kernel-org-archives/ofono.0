Content-Type: multipart/mixed; boundary="===============7483689560820556692=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 5/6] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 06:56:21 +0200
Message-ID: <CAKSBH7HpdhAeBkgsN_3ManC5E_-G-g+7CNK3PiumsrwEGRnEVQ@mail.gmail.com>
In-Reply-To: <0a343772-c62b-99d4-f93d-ff8044d61f93@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7483689560820556692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Oct 12, 2018 at 5:56 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> > +static void at_set_reg_info(const struct ofono_lte *lte,
> > +                     const struct ofono_lte_default_attach_info *info)
> >   {
> > -     struct cb_data *cbd =3D user_data;
> > -     ofono_lte_cb_t cb =3D cbd->cb;
> > -     struct ofono_error error;
> > +     struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
> > +     char buf_cgdcont[32 + OFONO_GPRS_MAX_APN_LENGTH  +1];
> > +     char buf_cgauth[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
> > +                                     OFONO_GPRS_MAX_PASSWORD_LENGTH +1=
];
>
> Please pay attention to doc/coding-style.txt item M3

ok

>
> > +     guint buflen =3D sizeof(buf_cgauth);
> > +     enum ofono_gprs_auth_method auth_method;
> >
> > -     DBG("ok %d", ok);
> > +     if (strlen(info->apn) > 0)
> > +             snprintf(buf_cgdcont, sizeof(buf_cgdcont),
> > +                             "AT+CGDCONT=3D0,\"IP\",\"%s\"", info->apn=
);
> > +     else
> > +             snprintf(buf_cgdcont, sizeof(buf_cgdcont),
> > +                             "AT+CGDCONT=3D0,\"IP\"");
>
> You're not taking IPv4/v6/Dual into account?  Why bother adding that
> property then?
>

you are right. I did add them in a switch for vendors to be submitted
once this overall change is accepted, but not here.
I'll submit taking it into account.

> >
> > -     decode_at_error(&error, g_at_result_final_response(result));
> > -     cb(&error, cbd->data);
> > +     if (g_at_chat_send(ldd->chat, buf_cgdcont, NULL, NULL, NULL, NULL=
) =3D=3D 0)
> > +             return;
>
> Uhh, you can't just return here

I'll look into it.

>
> > +
> > +     snprintf(buf_cgauth, buflen, "AT+CGAUTH=3D0,");
> > +     buflen -=3D strlen(buf_cgauth);
>
> You have way too many unnecessary strlen calls.  Refer to 'man snprintf'
> (particularly the return value) to understand how these can be avoided.

yes, also Jonas mentioned that. I will look into it.

>
> > +
> > +     auth_method =3D info->auth_method;
> > +
> > +     /*
> > +      * change the authentication method if the  parameters are invalid
> > +      * for behavior compatibility
> > +      */
> > +     if(!*info->username || !*info->password)
> > +             auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> > +
> > +     switch(auth_method) {
> > +     case OFONO_GPRS_AUTH_METHOD_PAP:
> > +             snprintf(buf_cgauth+strlen(buf_cgauth),
> > +                             buflen, "1,\"%s\",\"%s\"",
> > +                             info->username, info->password);
> > +             break;
> > +     case OFONO_GPRS_AUTH_METHOD_CHAP:
> > +             snprintf(buf_cgauth+strlen(buf_cgauth),
> > +                             buflen, "2,\"%s\",\"%s\"",
> > +                             info->username, info->password);
> > +             break;
> > +     case OFONO_GPRS_AUTH_METHOD_NONE:
> > +             snprintf(buf_cgauth+strlen(buf_cgauth), buflen, "0");
> > +             break;
> > +     }
> > +
> > +     g_at_chat_send(ldd->chat, buf_cgauth, NULL, NULL, NULL, NULL);
>
> Anyway.  All this boils down to is a +CGDCONT and a +CGAUTH call
> whenever a property changes.  And you even take into account
> username/password not being valid to override the auth method.  So I
> really see no point for set_reg_info now?

ok, I desist and run the two commands on the go, as many times as the
properties are changed.
At least there won't be discussion on where to call set_reg_info and -
mainly - it will solve the immediate callback issue.

>
> >   }
> >
> >   static void at_lte_set_default_attach_info(const struct ofono_lte *lt=
e,
> >                       const struct ofono_lte_default_attach_info *info,
> >                       ofono_lte_cb_t cb, void *data)
> >   {
> > -     struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
> > -     char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
> > -     struct cb_data *cbd =3D cb_data_new(cb, data);
> > -
> > -     DBG("LTE config with APN: %s", info->apn);
> > -
> > -     if (strlen(info->apn) > 0)
> > -             snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\",\"%s\"",
> > -                             info->apn);
> > -     else
> > -             snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\"");
> > -
> > -     /* We can't do much in case of failure so don't check response. */
> > -     if (g_at_chat_send(ldd->chat, buf, NULL,
> > -                     at_lte_set_default_attach_info_cb, cbd, g_free) >=
 0)
> > -             return;
> > -
> > -     CALLBACK_WITH_FAILURE(cb, data);
> > +     CALLBACK_WITH_SUCCESS(cb, data);
>
> So why do we even bother having a driver method that does literally nothi=
ng?

that could be an alternate solution: checking the method for null in
src/lte.c, but I will go for the immediate application of the
parameters.

>
> >   }
> >
> >   static gboolean lte_delayed_register(gpointer user_data)
> >   {
> > -     struct ofono_lte *lte =3D user_data;
> > -
> > -     ofono_lte_register(lte);
> > +     ofono_lte_register(user_data);
> >
> >       return FALSE;
> >   }
> > @@ -129,6 +149,7 @@ static struct ofono_lte_driver driver =3D {
> >       .probe                          =3D at_lte_probe,
> >       .remove                         =3D at_lte_remove,
> >       .set_default_attach_info        =3D at_lte_set_default_attach_inf=
o,
> > +     .set_reg_info                   =3D at_set_reg_info,
> >   };
> >
> >   void at_lte_init(void)
> >
>
> Regards,
> -Denis

Regards,
Giacinto

--===============7483689560820556692==--

