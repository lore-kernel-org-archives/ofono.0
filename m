Content-Type: multipart/mixed; boundary="===============7555826958361227084=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: allow pause to be sent through SendTones()
Date: Mon, 21 Mar 2011 14:04:59 -0500
Message-ID: <4D87A15B.7000509@gmail.com>
In-Reply-To: <1300491587-1400-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7555826958361227084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 03/18/2011 06:39 PM, Lucas De Marchi wrote:
> manager_tone() converts all tone chars to uppercase. Since everywhere we
> check for both 'p' and 'P' for a pause, tone_queue() should also check
> both before claiming the string is invalid.
> ---
>  src/voicecall.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============7555826958361227084==--

