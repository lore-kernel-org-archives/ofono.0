Content-Type: multipart/mixed; boundary="===============4542872123489002194=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Mon, 17 Jan 2011 19:51:04 +0100
Message-ID: <AANLkTikwpMtRGgsPSfgd4=2wAkg9auNcShnSDf_=WTK0@mail.gmail.com>
In-Reply-To: <AANLkTik_iqS0+hwV5OyaENQ40mY16n3-wWEVLV2XLVU7@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4542872123489002194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

So far we have been discussing CID races, but if we solve the CID issue,
we still might end up with two "identical" Connections activated with the s=
ame
connection properties (APN, Username, Password), one initiated by the modem
in the LTE Combined Attach procedure and the other being a "normal" Context
Activation, right?

How do we protect against establishing two contexts with the same propertie=
s?

Also: what is the likelihood of not having information the initial PDN
defined in the
provisioning database, would this be an exceptional case only?

Regards,
Sjur

--===============4542872123489002194==--

