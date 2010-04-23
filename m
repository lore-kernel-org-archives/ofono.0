Content-Type: multipart/mixed; boundary="===============6522323950990486736=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix: transaction id usage in gisi/server.c
Date: Fri, 23 Apr 2010 12:43:41 -0500
Message-ID: <201004231243.41642.denkenz@gmail.com>
In-Reply-To: <1272035836-27549-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6522323950990486736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  gisi/server.c |  111
>  +++++++++++++++++++++++++++----------------------------- 1 files changed,
>  54 insertions(+), 57 deletions(-)

WARNING: space prohibited between function name and open parenthesis '('
#95: FILE: gisi/server.c:88:
+	memset (self, 0, sizeof(*self));

I was nice and fixed it for you this time.  Please get into a habit of chec=
king =

your patches with checkpatch.

Patch has been applied, thanks.

Regards,
-Denis

--===============6522323950990486736==--

