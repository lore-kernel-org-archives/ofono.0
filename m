Content-Type: multipart/mixed; boundary="===============5763564849313011423=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ublox: Disable DCD to avoid HUP when leaving data mode.
Date: Thu, 05 Oct 2017 11:21:02 -0500
Message-ID: <ebf9abfe-b376-d64c-b719-cb8a5037bc2c@gmail.com>
In-Reply-To: <1507142970.10910.2.camel@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5763564849313011423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 10/04/2017 01:49 PM, Richard R=C3=B6jfors wrote:
> The HUP results in errors in gatio which will deref parts
> of the AT channel. This makes it impossible to recover and
> send further AT commands after the HUP.
> ---
>   plugins/ublox.c | 2 ++
>   1 file changed, 2 insertions(+)

Applied, thanks.

Regards,
-Denis

--===============5763564849313011423==--

