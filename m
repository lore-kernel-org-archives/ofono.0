Content-Type: multipart/mixed; boundary="===============6691709023290383153=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH 2/2] Added SQLite history plugin
Date: Tue, 06 Apr 2010 09:12:18 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9C138D967@orsmsx508.amr.corp.intel.com>
In-Reply-To: <4BBB132B.1030805@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6691709023290383153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Bastian, Waldo ha scritto:
> > The message handling in this patch seems to be vulnerable to SQL
> injection attacks. See http://en.wikipedia.org/wiki/SQL_injection
> >
> > Cheers,
> > Waldo
> =

> Hi Waldo,
> I didn't think of a message carrying an SQL injection :)
> Honestly I would use prepared statement since start of the job but I
> didn't manage how to do them in SQLite but I agree with you they're more
> secure and the code is cleaner, so I converted the source to them after
> studying their use.

Thanks, much better :-)

Cheers,
Waldo

--===============6691709023290383153==--

