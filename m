Content-Type: multipart/mixed; boundary="===============3599214804289578948=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH v4 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 10:01:44 +0200
Message-ID: <CAKSBH7E+0XikiXST7czB+JWk+BtQaS2TWV8+xs6qbhwCSpj4QA@mail.gmail.com>
In-Reply-To: <cae21e96-7824-6e1c-7bb8-0d73b5139528@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3599214804289578948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again,

On Wed, Oct 17, 2018 at 8:28 AM Jonas Bonn <jonas@southpole.se> wrote:
>
> Hi,
>
>
> On 17/10/18 06:52, Giacinto Cifelli wrote:
> > Added voicecall atom specific for Gemalto modems.

> > diff --git a/drivers/gemaltomodem/voicecall.c b/drivers/gemaltomodem/vo=
icecall.c
> > new file mode 100644
> > index 00000000..8e2c7e10
> > --- /dev/null
> > +++ b/drivers/gemaltomodem/voicecall.c
> > @@ -0,0 +1,581 @@

> > +static void gemalto_send_dtmf(struct ofono_voicecall *vc, const char *=
dtmf,
> > +                     ofono_voicecall_cb_t cb, void *data)
> > +{
> > +     int len =3D strlen(dtmf);
> > +     int s;
> > +     int i;
> > +     char *buf;
> > +     struct ofono_modem *modem =3D ofono_voicecall_get_modem(vc);
> > +     int use_quotes =3D ofono_modem_get_integer(modem, "GemaltoVtsQuot=
es");
> > +
> > +     /* strlen("+VTS=3D\"T\";") =3D 9 + initial AT + null */
> > +     buf =3D g_new(char, len * 9 + 3);
>
> Use alloca() instead... currently you are leaking buf.

Gladly, excellent idea.
Stack allocation is very sparingly used in ofono, while it would be a
better alternative in many cases.

Regards,
Giacinto

--===============3599214804289578948==--

