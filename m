Content-Type: multipart/mixed; boundary="===============6534589676839977963=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix build outside of tree after linker script change
Date: Wed, 22 Sep 2010 09:22:48 +0900
Message-ID: <1285114968.20811.56.camel@localhost.localdomain>
In-Reply-To: <1285087254-28185-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6534589676839977963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> Let configure generate connman.ver file and copy it to the build
> directory.
> ---
>  .gitignore       |    1 +
>  configure.ac     |    2 +-
>  src/ofono.ver    |    7 -------
>  src/ofono.ver.in |    7 +++++++
>  4 files changed, 9 insertions(+), 8 deletions(-)
>  delete mode 100644 src/ofono.ver
>  create mode 100644 src/ofono.ver.in

I fixed this properly with using $(srcdir). No extra file creation
needed.

Regards

Marcel



--===============6534589676839977963==--

