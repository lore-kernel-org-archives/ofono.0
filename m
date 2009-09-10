Content-Type: multipart/mixed; boundary="===============7455296888903939585=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Keep modem->powered_pending up to date after set_powered.
Date: Thu, 10 Sep 2009 16:32:10 -0500
Message-ID: <200909101632.11264.denkenz@gmail.com>
In-Reply-To: <1252601831-7907-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7455296888903939585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Without this once a request to power up the modem fails, modem.c won't
> retry even when asked.

Good catch.  Patch has been applied.

Regards,
-Denis

--===============7455296888903939585==--

