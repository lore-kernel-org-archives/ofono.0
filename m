Content-Type: multipart/mixed; boundary="===============7406744985004988744=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] main: add capabilities for phonet
Date: Mon, 01 Nov 2010 17:29:07 +0100
Message-ID: <1288628947.3322.112.camel@aeonflux>
In-Reply-To: <1288626782-16009-3-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7406744985004988744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> Phonet sockets require CAP_SYS_ADMIN and SO_BINDTODEVICE socket
> option requires CAP_NET_RAW.

and I so thought that we get away with lower capabilities :(

> ---
>  src/main.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Patch has been applied.

Regards

Marcel



--===============7406744985004988744==--

