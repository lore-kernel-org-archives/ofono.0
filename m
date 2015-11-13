Content-Type: multipart/mixed; boundary="===============2806387709278355417=="
MIME-Version: 1.0
From: Petr Vorel <petr.vorel@gmail.com>
Subject: Re: [PATCH 2/2] don't redefine GNU_SOURCE
Date: Sat, 14 Nov 2015 00:05:02 +0100
Message-ID: <20151113230501.GA5853@t61>
In-Reply-To: <508E3E53-7866-4BCA-B1B5-92AB37417DFE@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2806387709278355417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> lets not do that. Either we have #define _GNU_SOURCE in the files that ne=
ed it or we let config.h set it unconditionally. However we are not #ifdef =
around it ever.
sorry for wrong post. I was wrong (_GNU_SOURCE is redefined due buildroot c=
onfig). I
posted other patch, which adds missing _GNU_SOURCE.

Kind regards,
Petr

--===============2806387709278355417==--

