Content-Type: multipart/mixed; boundary="===============6841248537050933259=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 6/6] Add PPP option to gsmdial
Date: Mon, 22 Mar 2010 23:30:16 -0700
Message-ID: <1269325816.11714.28.camel@localhost.localdomain>
In-Reply-To: <20100323053034.GA17646@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6841248537050933259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> > +static void connect_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> > +{
> > +	GIOChannel *channel;
> > +
> > +	if (!ok) {
> > +		g_print("Unable to define context\n");
> > +		exit(1);
> =

> I guess we should not call exit here. Just return.

it is a test program. So it doesn't really matter. We will never install
this program. It is just for the developers ;)

Regards

Marcel



--===============6841248537050933259==--

