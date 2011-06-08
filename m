Content-Type: multipart/mixed; boundary="===============2861932328078211167=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 2/4] Add basic Telit UC864-G support:
Date: Wed, 08 Jun 2011 04:29:05 -0500
Message-ID: <4DEF40E1.2050307@gmail.com>
In-Reply-To: <1307546317-31831-2-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2861932328078211167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

On 06/08/2011 10:18 AM, Bernhard.Guillon(a)hale.at wrote:
> From: Bernhard Guillon <Bernhard.Guillon@hale.at>
> =

> *add a basic plugin based on different ofono plugins
> *use Telit specific QSS for SIM-state
> *update Makefile
> ---
>  Makefile.am     |    3 +
>  plugins/telit.c |  379 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 382 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/telit.c
> =


Patch has been applied, thanks.  I did modify the commit message
somewhat and added 3 simple commits afterwards.  Please check these
starting with commit 025fe0a74d1aa34a3c72054029d23ef4425abc6d and make
sure you're OK with these.

Now we just need to solve the udev integration part.

Regards,
-Denis

--===============2861932328078211167==--

