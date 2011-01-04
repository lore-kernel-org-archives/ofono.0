Content-Type: multipart/mixed; boundary="===============0444492492583794980=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] dbus: fix appending on dict for types other than string
Date: Tue, 04 Jan 2011 12:11:22 -0800
Message-ID: <1294171882.5852.105.camel@aeonflux>
In-Reply-To: <AANLkTinbUGoqCPTAhgEGcP2DNJayFYhaOy5sShJ8gDpm@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0444492492583794980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> > the append_basic D-Bus function works fine on **char and *uint8. So
> > either a pointer to a string (*char) or pointer to a byte (uint8.
> >
> > You differentiate between pointer to a string and pointer to a byte in
> > that function. So it is different since normally it is the caller that
> > has to give the right pointer in the first place.
> =

> Yeah, true... But if we don't differentiate the types here I'd need to
> cast an uint8 to void* that is not even allowed by our warning flags

as I said, I am fine with checking the type, but I would like to see a
comment in the code why we differentiate in this case.

Regards

Marcel



--===============0444492492583794980==--

