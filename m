Content-Type: multipart/mixed; boundary="===============2318117341981079471=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 4/4] atmodem: sim-auth atom driver.
Date: Fri, 21 Jan 2011 19:07:43 +0200
Message-ID: <AANLkTi=J+3mGKBz3RrveP7t3Lcz3jhCL009TAxE-1_wv@mail.gmail.com>
In-Reply-To: <4D38711A.6040608@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2318117341981079471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/1/20 Denis Kenzior <denkenz@gmail.com>:
> My view is that checking mallocs of small structures is pretty much
> pointless on Linux.


The glib functions that ofono uses extensively don't do any malloc
checking, and it makes checking on the  ofono side bit pointless. If
malloc fails, ofono will crash. If it has not get killed by oom
police.

-- =

Pekka.Pessi mail at nokia.com

--===============2318117341981079471==--

