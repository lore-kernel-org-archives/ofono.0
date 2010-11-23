Content-Type: multipart/mixed; boundary="===============0118515837567033803=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] string_to_phone_number: remove redumdant predicate
Date: Tue, 23 Nov 2010 06:49:46 -0600
Message-ID: <4CEBB86A.1030203@gmail.com>
In-Reply-To: <1290516038-7926-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0118515837567033803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 11/23/2010 06:40 AM, R=C3=A9mi Denis-Courmont wrote:
> If the first character is a plus sign, then it is not a nul, then
> the string length is true anyway.
> ---
>  src/common.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============0118515837567033803==--

