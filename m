Content-Type: multipart/mixed; boundary="===============5806780123621377826=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: Re: [PATCH v2 0/9] HSP profile implementation
Date: Mon, 21 Mar 2011 19:10:06 +0100
Message-ID: <4D87947E.2080702@linux.intel.com>
In-Reply-To: <AANLkTi=5w-3j1fE5BwEZQMYpC_UYbO=oMfVM+hJw2ddn@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5806780123621377826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Luiz,
> that is the plan then I suggest we first define a D-Bus spec on how to
> signal things like SLC and NREC to BlueZ, the record and socket
> listening/connection handling logic could also be done in BlueZ side
> so we use D-Bus to transfer the fd to oFono.
I didn't expect that yet, but if everybody agrees, why not!

>> * What is the behavior of hsp when receiving CKPD=3D200?
> This is what oFono does in BlueZ:
> 	if (waiting)
> 		err =3D answer_call(waiting);
> 	else if (active)
> 		err =3D release_call(active);
> 	else
> 		err =3D 0;
I'm fine with it!
If there is no call setup, is it worth trying to enable voice recognition?


Thanks,
Fr=C3=A9d=C3=A9ric


--===============5806780123621377826==--

