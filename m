Content-Type: multipart/mixed; boundary="===============0775818535738859911=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Save CellBroadcast Topics list, handle EF-CBMI,
 EF-CBMIR.
Date: Tue, 12 Jan 2010 18:09:56 -0600
Message-ID: <201001121809.57375.denkenz@gmail.com>
In-Reply-To: <fb249edb1001110638q1f87d5fbq4fb2a800c8b2c1f8@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0775818535738859911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> You're right, here's a new version which skips reading CBMI / CBMIR
> when not necessary, then reads CBMID (which will normally be in cache)
> and then sets powered updating the topics list with contents of CBMID
> and user topics.

Patch has been applied, thanks.

Regards,
-Denis

--===============0775818535738859911==--

