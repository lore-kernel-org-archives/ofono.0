Content-Type: multipart/mixed; boundary="===============6694900632470137814=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] voicecall: __ofono_voicecall_tone_send internal api.
Date: Fri, 22 Oct 2010 22:54:13 -0500
Message-ID: <4CC25C65.60406@gmail.com>
In-Reply-To: <1287637748-7230-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6694900632470137814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/21/2010 12:09 AM, Andrzej Zaborowski wrote:
> This provides a way for other atoms to send DTMF tones during a call.
> It is assumed that vc->driver->send_tone returns only after the tones
> have finished being emitted.
> =

> In this version Dbus DTMF requests are in the same queue as STK
> requests.
> ---
>  src/ofono.h     |    6 ++
>  src/voicecall.c |  269 ++++++++++++++++++++++++++++++++++++++++++++++++-=
------
>  2 files changed, 243 insertions(+), 32 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============6694900632470137814==--

