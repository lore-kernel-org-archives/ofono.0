Content-Type: multipart/mixed; boundary="===============7890959375642405872=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: vendor-specific shared functions
Date: Fri, 12 Oct 2018 06:38:53 +0200
Message-ID: <CAKSBH7GA_U2_Lrjnp4vN=62ies-gidA3SKGY5++a5S1+ncUw-Q@mail.gmail.com>
In-Reply-To: <CAKSBH7FQNkfV7SXiDgLp964xYs+8GCY-mBUyj4awU-AfpZ7H4g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7890959375642405872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

What about this question?

On Wed, Oct 10, 2018 at 10:09 AM Giacinto Cifelli <gciofono@gmail.com> wr=
ote:
>
> Dear all,
>
> I have a question for shared functions among atoms, but vendor-specific.
>
> For Gemalto, I have these two for now:
>
> gboolean gemalto_get_auth_command(struct ofono_modem *modem, int cid,
> enum ofono_gprs_auth_method auth_method,
> const char *username, const char *password,
> char *buf, guint buflen);
>
> void gemalto_get_cgdcont_command(struct ofono_modem *modem,
> guint cid, enum ofono_gprs_proto proto, const char *apn,
> char *buf, guint buflen);
>
> that will be used by gprs-context and lte atoms.
>
> I saw that also uBlox might benefit from the same shared functions,
> because they prepend "PAP:" or "CHAP:" to the APN name if the
> authentication is used.
> For other vendors I don't know because the specifications are not
> public, but there are loads of URC-parsing functions, sometimes
> already duplicated.
>
> I would like to set my functions in atmodem/utils.c, with headers in
> atmodem/utils.h.
> But maybe it is better to use atmodem/vendor.h and create an atmodem/vend=
or.c ?
> Or duplicate them?
>
> Any suggestion is appreciated.
>
> thank you,
> Regards,
> Giacinto

thanks,
Giacinto

--===============7890959375642405872==--

