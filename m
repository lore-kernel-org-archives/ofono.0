Content-Type: multipart/mixed; boundary="===============6845872486586417365=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/6] Don't remove atoms when state goes from INSERTED
 to NOT PRESENT.
Date: Mon, 10 May 2010 15:28:32 -0500
Message-ID: <201005101528.32225.denkenz@gmail.com>
In-Reply-To: <1273192008-11131-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6845872486586417365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> ---
>  src/modem.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> =

> diff --git a/src/modem.c b/src/modem.c
> index 8319702..0d0cb2a 100644

Patch has been applied with a modified description.  However, I'm thinking =
we =

should manipulate the lists directly based on SIM presence / pin state insi=
de =

ofono_modem_add_atom.  The logic is a little too complicated now.

Regards,
-Denis

--===============6845872486586417365==--

