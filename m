Content-Type: multipart/mixed; boundary="===============4710571234904932020=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/2] gemalto: add PIN retries support in plugin
Date: Tue, 07 Nov 2017 09:59:25 -0600
Message-ID: <3c9c2d6d-d5ee-4a33-291d-199c83080b7c@gmail.com>
In-Reply-To: <1509976629-9430-2-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4710571234904932020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On 11/06/2017 07:57 AM, Gabriel Lucas wrote:
> In SimManager, the Retries property isn't used for gemalto modems.
> The at command AT^SPIC is used to get the remaining retries left
> for the current required password type.
> =

> This commit enable the use of the driver in the gemalto plugin
> ---
>   plugins/gemalto.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis


--===============4710571234904932020==--

