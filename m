Content-Type: multipart/mixed; boundary="===============3449833137246463265=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Terminating emergency calls
Date: Thu, 12 Aug 2010 19:39:58 +0200
Message-ID: <AANLkTik4EnzzKZi6JEk8Ai+it9C4z3YL+Rr95fG51z94@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3449833137246463265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis.

I thought of one more issue with voice calls.
I don't think it is safe to to terminate emergency calls using
release_specific, AT+CHLD=3D1X.
At least this don't work for STE modems.

I suggest calls in state active should be terminated using hangup_all
or hangup_active.
What do you think?

Regards
Sjur

--===============3449833137246463265==--

