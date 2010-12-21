Content-Type: multipart/mixed; boundary="===============1296020990235184932=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Tue, 21 Dec 2010 18:39:43 +0200
Message-ID: <201012211839.43637.remi.denis-courmont@nokia.com>
In-Reply-To: <AANLkTimQrZf18yYMcwUiYV1Akr+rBChX_tatW9CKajhB@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1296020990235184932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 21 December 2010 17:54:53 ext Aki Niemi, you wrote:
>  It might make sense in some platforms,
> especially those that don't have a working monotonic clock...

That's a stupid requirement. Without a working clock, you can't get things =

like poll(), select() or nanosleep() to work. So glib won't work and so oFo=
no =

won't work either.

That use case is just FUD.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============1296020990235184932==--

