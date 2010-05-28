Content-Type: multipart/mixed; boundary="===============2744452676085814925=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 11/11] Style corrections.
Date: Fri, 28 May 2010 12:20:07 -0500
Message-ID: <201005281220.07678.denkenz@gmail.com>
In-Reply-To: <1274957690-4893-11-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2744452676085814925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> From: Pasi Miettinen <pasi.miettinen@ixonos.com>
> =

> ---
>  src/sms.c |   25 ++++++++++++++-----------
>  1 files changed, 14 insertions(+), 11 deletions(-)
> =


Style correction patches for code introduced in the same series should simp=
ly =

be squished into the previous changes.  This makes it much easier for us to =

review.  e.g. this patch should not exist and any corrections made to the =

patches that originally introduced the code.

Regards,
-Denis

--===============2744452676085814925==--

