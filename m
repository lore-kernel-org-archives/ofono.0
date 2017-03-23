Content-Type: multipart/mixed; boundary="===============3827605243060343784=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/5] qmimodem: telit LE910 V1 - fix ESN string
Date: Thu, 23 Mar 2017 10:32:22 -0500
Message-ID: <61f26d1d-ab29-3a69-a5d2-f2d641232a74@gmail.com>
In-Reply-To: <1490206493-17454-2-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3827605243060343784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/22/2017 01:14 PM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Telit QMI modems report "0", rather than a NULL string,
> if ESN is not available.
> ---
>  drivers/qmimodem/devinfo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

I went ahead and applied this patch, however you forgot to include =

string.h for this change.  I added a follow-on commit to fix this.

Regards,
-Denis

--===============3827605243060343784==--

