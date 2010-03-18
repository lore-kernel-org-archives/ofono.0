Content-Type: multipart/mixed; boundary="===============2376874950491337700=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [patch 2/6] Generic PPP control protocol
Date: Thu, 18 Mar 2010 16:03:57 -0700
Message-ID: <20100318160357.777b3ee7@kcaccard-MOBL3>
In-Reply-To: <1268809594.2700.101.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2376874950491337700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Mar 2010 00:06:34 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> > +struct pppcp_data;  =

> =

> Why is this needed?

this is needed because we have some circular dependencies in the
pppcp_data structure and the pppcp_actions structure.

--===============2376874950491337700==--

