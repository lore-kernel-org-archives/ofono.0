Content-Type: multipart/mixed; boundary="===============4533354533401029388=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] mbmmodem: don't let chat open after fd is sent
Date: Thu, 03 Mar 2011 09:59:36 -0800
Message-ID: <1299175176.2519.70.camel@aeonflux>
In-Reply-To: <AANLkTinT54+-0eAyjgfeWrzaBQsgEzVJeC8B8i=qAipW@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4533354533401029388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> >>  struct gps_data {
> >>       GAtChat *chat;
> >> -     GAtChat *data_chat;
> >> +
> >> +     struct {
> >> +             GIOChannel *channel;
> >> +             guint idle_source;
> >> +             gsize written;
> >> +             ofono_location_reporting_enable_cb_t cb;
> >> +             void *cb_data;
> >> +     } stream;
> >>  };
> >
> > why do you bother with the struct in struct here?
> =

> Just to group these related fields.

I let Denis decide to take this or not. My preference is to not do this
unless it has some clear benefit, but that is just me ;)

Regards

Marcel



--===============4533354533401029388==--

