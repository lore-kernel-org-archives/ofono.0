Content-Type: multipart/mixed; boundary="===============3307720393730612400=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] 	build: Update glib version in configure.ac
Date: Fri, 19 Nov 2010 08:01:03 +0100
Message-ID: <1290150063.29148.27.camel@aeonflux>
In-Reply-To: <1290108063-3777-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3307720393730612400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi George,

> function g_mkstemp_full in src/storage.c
> requires glib version 2.22 or higher
> ---
>  configure.ac |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

patch looks good, but your subject line has a ^I character in it and I
prefer not to figure out what git does with it. So please fix this
first.

Regards

Marcel



--===============3307720393730612400==--

