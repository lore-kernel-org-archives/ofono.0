Content-Type: multipart/mixed; boundary="===============4244677230107362850=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] [RfC] doc: Proposed Set Up Call api.
Date: Wed, 18 Aug 2010 12:29:00 -0500
Message-ID: <4C6C185C.3040304@gmail.com>
In-Reply-To: <1282100467-890-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4244677230107362850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 08/17/2010 10:01 PM, Andrzej Zaborowski wrote:
> The normal sequence for call setup is:
> =

> * Modem asks user for confirmation using icon1 / alphaId1.
> * User confirms
> * Modem starts dialling, screen displays icon2 / alphaId2,
> * Call is connected, modem replies to the proactive command, screen
>   keeps displaying icon2 / alphaId2 until the phone call is over.
> ---
>  doc/stk-api.txt       |   11 +++++++++++
>  doc/voicecall-api.txt |   11 +++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> =


Since we have seemingly reached consensus on the API direction, I went
ahead and applied this patch.  Thanks.

Regards,
-Denis

--===============4244677230107362850==--

