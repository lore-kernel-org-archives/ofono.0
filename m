Content-Type: multipart/mixed; boundary="===============0207178441309542417=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] unify telit and xe910 plugins
Date: Thu, 02 Feb 2017 11:57:29 -0600
Message-ID: <c8d2a6a9-7d7e-0789-7e15-a15ed545c840@gmail.com>
In-Reply-To: <20170202140927.8152-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0207178441309542417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Piotr,

On 02/02/2017 08:09 AM, Piotr Haber wrote:
> Expect of Bluetooth SAP related funcionality
> most of the code in telit and xe910 plugins is the same.
> Also unify udevng initialization code.
>
> Piotr Haber (2):
>   plugins: rename xe910 to telit
>   udevng: unify telit and xe910
>
>  Makefile.am      |   7 +-
>  plugins/telit.c  | 550 +++++++++++++++++++++----------------------------=
------
>  plugins/udevng.c |  44 +----
>  plugins/xe910.c  | 546 -------------------------------------------------=
-----
>  4 files changed, 213 insertions(+), 934 deletions(-)
>  delete mode 100644 plugins/xe910.c
>

Both applied, thanks.

Regards,
-Denis

--===============0207178441309542417==--

