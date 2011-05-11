Content-Type: multipart/mixed; boundary="===============1358385663464116176=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] Fix primary context active/deactive result d-bus
 reply missing issue
Date: Wed, 11 May 2011 13:31:12 -0500
Message-ID: <4DCAD5F0.1050209@gmail.com>
In-Reply-To: <1303887867-6467-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1358385663464116176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 04/27/2011 02:04 AM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> If user offline modem when the gprs_context is in enabling or disabling
> state(activating/disactivating), the GPRS primary context activate/disact=
ivate
> result will not be replied to the corresponding application.
> ---
>  drivers/atmodem/gprs-context.c |    7 +++++++
>  src/gprs.c                     |    5 +++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
> =


Please check commit 4714d8199aacf0ba6be777a70e01b3016ba2aa5f, this might
partly fix this issue.

Regards,
-Denis

--===============1358385663464116176==--

