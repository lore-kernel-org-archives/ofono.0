Content-Type: multipart/mixed; boundary="===============0199616080389524514=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Tue, 06 Apr 2010 12:55:39 +0200
Message-ID: <4BBB132B.1030805@djdas.net>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9C138D0D0@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0199616080389524514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Bastian, Waldo ha scritto:
> The message handling in this patch seems to be vulnerable to SQL injectio=
n attacks. See http://en.wikipedia.org/wiki/SQL_injection
>
> Cheers,
> Waldo

Hi Waldo,
I didn't think of a message carrying an SQL injection :)
Honestly I would use prepared statement since start of the job but I =

didn't manage how to do them in SQLite but I agree with you they're more =

secure and the code is cleaner, so I converted the source to them after =

studying their use.
Thank you for your suggestion.
Best Regards,
Dario.


--===============0199616080389524514==--

