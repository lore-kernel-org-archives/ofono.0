Content-Type: multipart/mixed; boundary="===============7069646548513145914=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC online/offline atoms PATCH 4/4] isigen: create sms and gprs
 in post_sim
Date: Tue, 05 Oct 2010 19:40:24 -0500
Message-ID: <4CABC578.7070606@gmail.com>
In-Reply-To: <1286280264.17473.84.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7069646548513145914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> what advantage to we have from moving SMS and GPRS atom into the
> post_sim state? I am trying to really understand what this is trying to
> do and what is the difference of just doing it when in post_online
> state.

We'd like to be able to toggle GPRS settings even if in offline state.
There's nothing preventing us from creating / deleting / editing
contexts or setting the RoamingAllowed property for instance.

Regards,
-Denis

--===============7069646548513145914==--

