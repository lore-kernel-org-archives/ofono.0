Content-Type: multipart/mixed; boundary="===============1659044959315570436=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] atmodem: Delay return from send_dtmf
Date: Fri, 22 Oct 2010 22:56:07 -0500
Message-ID: <4CC25CD7.40900@gmail.com>
In-Reply-To: <1287637748-7230-3-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1659044959315570436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/21/2010 12:09 AM, Andrzej Zaborowski wrote:
> AT+VTS responds with an OK immediately, so add a wait in the driver
> before returning so that core knows when the tone has finished.  Note
> that some modems actually do wait against 27.007, and other modems
> use a manufacturer specific AT command and the drivers will need to
> handle accordingly.
> ---
>  drivers/atmodem/voicecall.c |   63 +++++++++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 61 insertions(+), 2 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============1659044959315570436==--

