Content-Type: multipart/mixed; boundary="===============9189696491243417853=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] atmodem/sms: added Gemalto vendor for CNMI command
Date: Tue, 23 Oct 2018 10:32:36 +0200
Message-ID: <CAKSBH7E8WvgnHEbGffcjXXz5AOJuRGMX81Qj_SNoFjaP95geFw@mail.gmail.com>
In-Reply-To: <7aaec38a-6b31-1e65-ce09-b78aa6807e7b@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9189696491243417853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 23, 2018 at 10:29 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>
> Hi,
>
> On 23/10/18 10:21, Giacinto Cifelli wrote:
> > ---
> >   drivers/atmodem/sms.c | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> > index 7638885e..380cd763 100644
> > --- a/drivers/atmodem/sms.c
> > +++ b/drivers/atmodem/sms.c
> > @@ -858,8 +858,18 @@ static gboolean build_cnmi_string(char *buf, int *=
cnmi_opts,
> >                                       data->cnma_enabled ? "21" : "1", =
FALSE))
> >               return FALSE;
> >
> > +     switch (data->vendor) {
> > +     case OFONO_VENDOR_GEMALTO:
> > +             mode =3D "0";
> > +             break;
> > +     default:
> > +             /* Sounds like 2 is the sanest mode */
>
> This particular comment doesn't add anything useful so just drop it.

Not mine... I didn't want my patch rejected because I changed 2 things
at the same time (add vendor and remove comment).
From the choice of word (sane), I think this comment is from Denis.
without even checking with git blame.

>
> /Jonas

Giacinto

--===============9189696491243417853==--

