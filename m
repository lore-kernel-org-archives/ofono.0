Content-Type: multipart/mixed; boundary="===============4170646235900405065=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Fri, 05 Oct 2018 04:23:22 +0200
Message-ID: <CAKSBH7GpyFOrgOYyKyq1bJf7nNQoNRdci1iymNcyOSdxAdPbjQ@mail.gmail.com>
In-Reply-To: <161f6b03-24dd-e00b-ea11-0e361dbb3d73@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4170646235900405065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Oct 5, 2018 at 4:20 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >> Ugh.  I really hate GCC people sometimes.  While the warning is strict=
ly
> >> correct, it is useless for 99% of the code and forces us to jump throu=
gh
> >> hoops.  Anyway, I would propose we use the following pattern:
> >>
> >> int auth_method_to_qmi(enum ofono_auth_method method, uint8_t *out_aut=
h)
> >> {
> >>          switch (method)
> >>          case CHAP:
> >>                  *out_auth =3D ...
> >>                  return 0;
> >>          case:
> >>                  ...
> >>          }
> >>
> >>          return -ERANGE;
> >> }
> >>
> >
> > I tried but it is worst. Now gcc complains about potentially
> > uninitialized variable.
> >
> > Here is the code
> > static int auth_method_to_qmi(enum ofono_gprs_auth_method method,
> > uint8_t *out_auth)
> > {
> >    switch (method) {
> >    case OFONO_GPRS_AUTH_METHOD_CHAP:
> >      *out_auth =3D QMI_WDS_AUTHENTICATION_CHAP;
> >      return 0;
> >    case OFONO_GPRS_AUTH_METHOD_PAP:
> >      *out_auth =3D QMI_WDS_AUTHENTICATION_PAP;
> >      return 0;
> >    case OFONO_GPRS_AUTH_METHOD_NONE:
> >      *out_auth =3D QMI_WDS_AUTHENTICATION_NONE;
> >      return 0;
> >    }
> >    return -1;
> > }
> >
> > static void qmi_activate_primary(struct ofono_gprs_context *gc,
> > [...]
> >    uint8_t auth;
> > [...]
> >    auth_method_to_qmi(ctx->auth_method, &auth);
>
> Well you might want to check for an error return here.  e.g.
>
> if (auth_method_to_qmi() < 0) {
>         CALLBACK_WITH_FAILURE();
>         return;
> }
>
> >
> > and here the compiler answer:
> >
> > drivers/qmimodem/gprs-context.c:288:2: error: =E2=80=98auth=E2=80=99 ma=
y be used
> > uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >    qmi_param_append_uint8(param, QMI_WDS_PARAM_AUTHENTICATION_PREFERENC=
E,
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> >        auth);
> >        ~~~~~
> >
> > It doesn't look like we have a clean way out of this. I can
> > pre-initialize the variable, add a default to the switch, return the
> > value for uint8 out_auth,
> > but none of these will give you a clean solution.
>
> No, we should not initialize variables unnecessarily.  This is even
> documented: doc/coding-style.txt, item M7

I know this, that's why there are 3 lines of comment on it.

>
> >
> > I prefer therefore to keep it as it is, with a comment about why it is =
done so.
> >
>
> I prefer we set a good example :)

Then the cleanest way is to set a default in the switch, without any functi=
on.
Ok?

>
> Regards,
> -Denis

Regards,
Giacinto

--===============4170646235900405065==--

