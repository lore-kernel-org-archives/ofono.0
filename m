Content-Type: multipart/mixed; boundary="===============4049430979703324572=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Fri, 05 Oct 2018 05:30:33 +0200
Message-ID: <CAKSBH7FuMX2xdZ0oNgKDzOz8WZQEp7g-9DBy8Utb-oFzWPVbBA@mail.gmail.com>
In-Reply-To: <5868f423-1fd0-febf-c3fc-6940ecab60f6@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4049430979703324572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

maybe it is only a misunderstanding, but...

On Fri, Oct 5, 2018 at 5:23 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> > You are not giving any choice here, other than rewriting gcc.
> > The function I have tried, and the compiler still complains.
> > I need a way out: please decide for the lesser evil, and I'll do it.
> >
>
> I already gave you two way out actually.  So tell me why either of the
> below wouldn't work:
>
> So for example, the way gprs-context.c for mbim does this is just fine.
>
> switch (method) {
> case CHAP:
>         return ..
> case PAP:
>         return ..
> }
>
> return something, anything;

this is in a function that assigns the variable for sure:

static uint32_t auth_method_to_auth_protocol(enum ofono_gprs_auth_method me=
thod)
{
switch (method) {
case OFONO_GPRS_AUTH_METHOD_CHAP:
return 2; /* MBIMAuthProtocolChap */
case OFONO_GPRS_AUTH_METHOD_PAP:
return 1; /* MBIMAuthProtocolPap */
}

return 0;  // < see here?
}

that's why the compiler doesnt complain.

>
> Since the core guarantees that method will always be a valid
> enumeration, the above approach is just fine and satisfies both items M7
> and M12.
>
> If you want to be more paranoid, then:
>
> int auth_method_to_foo(enum ofono_gprs_auth_method method, uint32_t *out)
> {
>         switch (method) {
>         case PAP:
>                 *out =3D ..
>                 return 0;
>         case CHAP:
>                 *out =3D ..
>                 return 0;
>         }
>
>         return -ERANGE;
> }
>
> uint32_t auth;
>
> if (auth_method_to_foo(method, &auth) < 0)
>         goto error;
>

this doesnt work, because it could leave the variable auth unassigned,
according to the compiler.

Please note that the current code for qmimodem has a default already,
and it is the only way the compiler doesn't complain:

switch (ctx->auth_method) {
case OFONO_GPRS_AUTH_METHOD_CHAP:
auth =3D QMI_WDS_AUTHENTICATION_CHAP;
break;
case OFONO_GPRS_AUTH_METHOD_PAP:
auth =3D QMI_WDS_AUTHENTICATION_PAP;
break;
default: // < see here?
auth =3D QMI_WDS_AUTHENTICATION_NONE;
break;
}

I will go for the mbim method.

> Regards,
> -Denis

Regards,
Giacinto

--===============4049430979703324572==--

