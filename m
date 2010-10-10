Content-Type: multipart/mixed; boundary="===============1780251292243241814=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [ussd-mmi PATCH 1/4] Fix valid_ussd_string()
Date: Sun, 10 Oct 2010 06:08:23 -0500
Message-ID: <4CB19EA7.9000708@gmail.com>
In-Reply-To: <1286376739-20677-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1780251292243241814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 10/06/2010 09:52 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> The valid_ussd_string() returns now true if MMI input is to be sent as
> USSD.
> =

> The comment about USSD routing is removed, it is out of scope of oFono.
> The cellular network routes the USSD requests based on the rules laid
> out in the 22.090, however, any string that can be encoded according to
> the rules of 23.038 is valid USSD.
> ---
>  src/common.c |   44 +++++++++++++++++++-------------------------
>  src/common.h |    2 +-
>  src/ussd.c   |   13 ++++++++++++-
>  3 files changed, 32 insertions(+), 27 deletions(-)
> =


Somehow this patch got mangled, so I had to be creative when trying to
apply it.  I broke it up into two patches and fixed up the style slightly.

Patch has been applied, thanks.

Regards,
-Denis

--===============1780251292243241814==--

