Content-Type: multipart/mixed; boundary="===============8607327310927069250=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 5/5] drivers: support for auth NONE
Date: Tue, 09 Oct 2018 20:51:52 +0200
Message-ID: <CAKSBH7Hntj5VWBX=pc4yT3tEMRexGLJZigLpb5YvHOHDX4seYA@mail.gmail.com>
In-Reply-To: <9110ae75-3245-7131-8a3e-92fb83fef5ce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8607327310927069250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Oct 9, 2018 at 7:41 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> I applied a modified version of this patch, see below:
>
> > diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-=
context.c
> > index 79793c92..be256e43 100644
> > --- a/drivers/mbimmodem/gprs-context.c
> > +++ b/drivers/mbimmodem/gprs-context.c
> > @@ -75,9 +75,11 @@ static uint32_t auth_method_to_auth_protocol(enum of=
ono_gprs_auth_method method)
> >               return 2; /* MBIMAuthProtocolChap */
> >       case OFONO_GPRS_AUTH_METHOD_PAP:
> >               return 1; /* MBIMAuthProtocolPap */
> > +     case OFONO_GPRS_AUTH_METHOD_NONE:
> > +             return 0; /* MBIMAUthProtocolNone */
> >       }
> >
> > -     return 0;
> > +     return 0; /* MBIMAUthProtocolNone */
> >   }
> >
> >   static void mbim_deactivate_cb(struct mbim_message *message, void *us=
er)
> > @@ -345,6 +347,8 @@ static void mbim_gprs_activate_primary(struct ofono=
_gprs_context *gc,
> >   {
> >       struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> >       struct mbim_message *message;
> > +     const char username =3D NULL;
> > +     const char password =3D NULL;
>
> These were changed to const char *

shame on me. I should have seen this...

>
> >
> >       DBG("cid %u", ctx->cid);
> >
> > @@ -354,6 +358,12 @@ static void mbim_gprs_activate_primary(struct ofon=
o_gprs_context *gc,
> >       gcd->active_context =3D ctx->cid;
> >       gcd->proto =3D ctx->proto;
> >
> > +     if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE && ctx->use=
rname[0])
> > +             username =3D ctx->username;
> > +
> > +     if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE && ctx->pas=
sword[0])
> > +             password =3D ctx->password;
> > +
> >       message =3D mbim_message_new(mbim_uuid_basic_connect,
> >                                       MBIM_CID_CONNECT,
> >                                       MBIM_COMMAND_TYPE_SET);
> > @@ -361,8 +371,8 @@ static void mbim_gprs_activate_primary(struct ofono=
_gprs_context *gc,
> >                               ctx->cid,
> >                               1, /* MBIMActivationCommandActivate */
> >                               ctx->apn,
> > -                             ctx->username[0] ? ctx->username : NULL,
> > -                             ctx->password[0] ? ctx->password : NULL,
> > +                             username,
> > +                             password,
> >                               0, /*MBIMCompressionNone */
> >                               auth_method_to_auth_protocol(ctx->auth_me=
thod),
> >                               proto_to_context_ip_type(ctx->proto),
> > diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-co=
ntext.c
> > index e961afa1..fa8b44b6 100644
> > --- a/drivers/mbmmodem/gprs-context.c
> > +++ b/drivers/mbmmodem/gprs-context.c
> > @@ -394,11 +394,12 @@ static void mbm_gprs_activate_primary(struct ofon=
o_gprs_context *gc,
> >        * Set username and password, this should be done after CGDCONT
> >        * or an error can occur.  We don't bother with error checking
> >        * here
> > -      * */
> > -     snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
> > -                     ctx->cid, ctx->username, ctx->password);
> > -
> > -     g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> > +      */
> > +     if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE) {
> > +             snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\=
"",
> > +                             ctx->cid, ctx->username, ctx->password);
> > +             g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, N=
ULL);
> > +     }
> >
> >       return;
> >
>
> I dropped this part entirely.  The reason is that we can have profiles
> with username/password & without operating on the same CID.  Since the
> setting is permanent on the modem, we need to set it/clear it even when
> AUTH_METHOD_NONE is used.

I don't know these modules, so I believe you and it is perfectly fine with =
me.

>
> If you disagree, please send a follow up series.
>
> > diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-co=
ntext.c
> > index 18b2bfa4..32facd8c 100644
> > --- a/drivers/stemodem/gprs-context.c
> > +++ b/drivers/stemodem/gprs-context.c
> > @@ -307,10 +307,11 @@ static void ste_gprs_activate_primary(struct ofon=
o_gprs_context *gc,
> >        * or an error can occur.  We don't bother with error checking
> >        * here
> >        */
> > -     snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
> > -                     ctx->cid, ctx->username, ctx->password);
> > -
> > -     g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> > +     if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE) {
> > +             snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\=
"",
> > +                             ctx->cid, ctx->username, ctx->password);
> > +             g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, N=
ULL);
> > +     }
> >
> >       return;
> >
>
> Dropped for the same reason as above
>
> Regards,
> -Denis

Regards,
Giacinto

--===============8607327310927069250==--

