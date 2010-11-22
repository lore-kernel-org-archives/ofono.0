Content-Type: multipart/mixed; boundary="===============6498712176699350754=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 4/5] voicecall: add call counters
Date: Mon, 22 Nov 2010 09:34:47 -0600
Message-ID: <4CEA8D97.4060202@gmail.com>
In-Reply-To: <68a1a9e9cf371358b6c100b372ae93a50e095bd7.1289819191.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6498712176699350754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 11/15/2010 05:50 AM, Andras Domokos wrote:
> ---
>  src/callcounters.c |  388 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 388 insertions(+), 0 deletions(-)
>  create mode 100644 src/callcounters.c
> =

> diff --git a/src/callcounters.c b/src/callcounters.c

This patch should go together with Patch 5.  It is also missing the API
documentation (which could be in a separate patch if you prefer).

This file should also be inside the plugins directory and not src.

Regards,
-Denis

--===============6498712176699350754==--

