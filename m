Content-Type: multipart/mixed; boundary="===============2764308980295045421=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] atmodem: Share common devinfo utilities
Date: Thu, 13 Jan 2011 00:01:11 -0600
Message-ID: <4D2E9527.7010308@gmail.com>
In-Reply-To: <1294782301-8592-2-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2764308980295045421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 01/11/2011 03:44 PM, Dara Spieker-Doyle wrote:
> ---
>  drivers/atmodem/atutil.c  |   56 +++++++++++++++++++++++++++++++++++++++=
+++
>  drivers/atmodem/atutil.h  |    2 +
>  drivers/atmodem/devinfo.c |   59 +++------------------------------------=
-----
>  3 files changed, 62 insertions(+), 55 deletions(-)
> =


So I found your approach a bit too evil and pushed my own version.  See
commit febb9014ca9056dda4e99ba8dfeb80ec77644b9a

Regards,
-Denis

--===============2764308980295045421==--

