Content-Type: multipart/mixed; boundary="===============8922515415953962861=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] dbus: fix appending on dict for types other than string
Date: Tue, 04 Jan 2011 17:46:15 -0200
Message-ID: <AANLkTinbUGoqCPTAhgEGcP2DNJayFYhaOy5sShJ8gDpm@mail.gmail.com>
In-Reply-To: <1294167373.5852.104.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8922515415953962861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Marcel

On Tue, Jan 4, 2011 at 4:56 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> the append_basic D-Bus function works fine on **char and *uint8. So
> either a pointer to a string (*char) or pointer to a byte (uint8.
>
> You differentiate between pointer to a string and pointer to a byte in
> that function. So it is different since normally it is the caller that
> has to give the right pointer in the first place.

Yeah, true... But if we don't differentiate the types here I'd need to
cast an uint8 to void* that is not even allowed by our warning flags


Lucas De Marchi

--===============8922515415953962861==--

