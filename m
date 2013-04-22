Content-Type: multipart/mixed; boundary="===============8160092258677343104=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 3/3] hfp_ag_bluez5: Implement RequestDisconnection()
Date: Mon, 22 Apr 2013 03:56:19 -0500
Message-ID: <5174FB33.4050200@gmail.com>
In-Reply-To: <1366409945-31401-3-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8160092258677343104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 04/19/2013 05:19 PM, Paulo Borges wrote:
> When a RequestDisconnect() is received, the socket must be closed.
> This way, the related emulator will be freed.
> ---
>   plugins/hfp_ag_bluez5.c |   30 +++++++++++++++++++++++++++---
>   1 file changed, 27 insertions(+), 3 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============8160092258677343104==--

