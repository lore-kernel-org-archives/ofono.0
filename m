Content-Type: multipart/mixed; boundary="===============0982644420293747541=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/1] Remove superfluous definitions of _GNU_SOURCE
Date: Wed, 17 Oct 2018 12:35:08 +0200
Message-ID: <CAKSBH7FaCYUOmpG6JYkzGMPxKEKXm+XDFeAZ0N9LDwrFEdmzgg@mail.gmail.com>
In-Reply-To: <20181017102304.5857-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0982644420293747541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 17, 2018 at 12:23 PM Jonas Bonn <jonas@norrbonn.se> wrote:
>
> There are a large number of files in the tree that define _GNU_SOURCE
> despite not actually using features hidden behind this flag.  This patch
> removes all these definitions in one fell swoop...
> ---
>
> I realize that it's not quite kosher in ofono to send pathes that touch
> more than directory.  Breaking this up into separate patches doesn't
> really make sense though, given its nature.  If the list insists,
> though, I can break this up into a series of ~50 patches...
>
> /Jonas

Do all files and the project compile?

A single patch seems better in this case, in my opinion - for what it's wor=
th -.

Regards,
Giacinto

--===============0982644420293747541==--

