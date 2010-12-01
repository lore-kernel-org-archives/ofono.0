Content-Type: multipart/mixed; boundary="===============7751583124847333192=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Thu, 02 Dec 2010 01:57:01 +0200
Message-ID: <AANLkTi=GEFf_s3XQ+TK82SigfJvCGcjGWPDjErzW4cxk@mail.gmail.com>
In-Reply-To: <1291023678.4795.26.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7751583124847333192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/11/29 Marcel Holtmann <marcel@holtmann.org>:
> Only because someone wants to shoehorn this into something nasty,
> doesn't mean we should do it.

I'd say it fits with oFono's overall strategy of following 27.007
whenever possible.

>And I am not going to scarifies the
> simplicity of the oFono D-Bus API for this.

Please. Have a look at the VoicecallManager API. Someone has
shoehorned all the nasty MMI-isms from 22.030 there. Surely we have to
have a separate ReleaseAndAnswer method, how else a dialer could
implement the intuitive "1" followed by SEND procedure?

-- =

Pekka.Pessi mail at nokia.com

--===============7751583124847333192==--

