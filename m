Content-Type: multipart/mixed; boundary="===============0144699135414048296=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Simplify linker script
Date: Tue, 21 Sep 2010 23:26:43 +0900
Message-ID: <1285079203.20811.54.camel@localhost.localdomain>
In-Reply-To: <1285073191-321-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0144699135414048296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> Version linker scripts support function names and globs, so there's no
> need to rely on nm tool to gather the exported symbols.
> ---
>  .gitignore    |    2 --
>  Makefile.am   |   12 +-----------
>  configure.ac  |    3 ---
>  src/ofono.ver |    7 +++++++
>  4 files changed, 8 insertions(+), 16 deletions(-)
>  create mode 100644 src/ofono.ver

patch has been applied. Thanks.

Regards

Marcel



--===============0144699135414048296==--

