Content-Type: multipart/mixed; boundary="===============2384110846279801072=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v0 1/6] doc: Add DormantInterval property
Date: Thu, 08 Dec 2011 05:00:53 -0600
Message-ID: <4EE098E5.6010202@gmail.com>
In-Reply-To: <4EE0826F.50707@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2384110846279801072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> Right, the user can't manage this value, however Dormant property is
> ReadOnly.
> So should we have a specific DBus API to disable/enable the dormancy mode?
> =


No, just turn it off in the modem.  If the network forces us into
Dormant mode, so be it.  The API is modeled correctly right now.

Regards,
-Denis

--===============2384110846279801072==--

