Content-Type: multipart/mixed; boundary="===============3412050266388638283=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 2/6] Generic PPP control protocol
Date: Fri, 19 Mar 2010 04:57:05 +0100
Message-ID: <1268971025.3003.2.camel@violet>
In-Reply-To: <20100318160357.777b3ee7@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3412050266388638283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> > > +struct pppcp_data;  =

> > =

> > Why is this needed?
> =

> this is needed because we have some circular dependencies in the
> pppcp_data structure and the pppcp_actions structure.

you might be absolutely right that this is needed. And it is cleanest
way to do it. However every time I see forward declarations and hear
circular dependencies, I question if the code might not be too complex.

Please keep this in mind. We will revisit this again when doing a deep
down dive review after the merge.

Regards

Marcel



--===============3412050266388638283==--

