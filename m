Content-Type: multipart/mixed; boundary="===============8123553751882187159=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC online/offline atoms PATCH 4/4] isigen: create sms and gprs
 in post_sim
Date: Wed, 06 Oct 2010 10:55:10 +0200
Message-ID: <1286355310.6145.21.camel@aeonflux>
In-Reply-To: <4CABC578.7070606@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8123553751882187159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > what advantage to we have from moving SMS and GPRS atom into the
> > post_sim state? I am trying to really understand what this is trying to
> > do and what is the difference of just doing it when in post_online
> > state.
> =

> We'd like to be able to toggle GPRS settings even if in offline state.
> There's nothing preventing us from creating / deleting / editing
> contexts or setting the RoamingAllowed property for instance.

same as with SMS. Good enough reason for me to do it this way.

Regards

Marcel



--===============8123553751882187159==--

