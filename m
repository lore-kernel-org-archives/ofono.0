Content-Type: multipart/mixed; boundary="===============0380165165278782693=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH -v3 2/3] phonesim: Add modem reset trigger
Date: Tue, 23 Nov 2010 18:01:33 -0200
Message-ID: <20101123200133.GE22502@vigoh>
In-Reply-To: <4CEB9E95.8000703@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0380165165278782693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Denis Kenzior <denkenz@gmail.com> [2010-11-23 04:59:33 -0600]:

> Hi Gustavo,
> =

> On 11/19/2010 03:36 PM, Gustavo F. Padovan wrote:
> > ---
> >  plugins/phonesim.c |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> > =

> > diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> > index d2faf42..7426da6 100644
> > --- a/plugins/phonesim.c
> > +++ b/plugins/phonesim.c
> > @@ -237,6 +237,13 @@ static void cfun_set_on_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
> >  	ofono_modem_set_powered(modem, ok);
> >  }
> >  =

> > +static void crst_notify(GAtResult *result, gpointer user_data)
> > +{
> > +	struct ofono_modem *modem =3D user_data;
> > +
> > +	ofono_modem_reset(modem);
> =

> I suggest you simply clean up the phonesim connection (e.g. closing the
> tcp socket) when you receive this notification, and then call
> modem_reset at the end.

So here do you mean unref phonesim data->chat and also call
ofono_modem_set_powered(modem, FALSE) before call ofono_modem_reset()?

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============0380165165278782693==--

