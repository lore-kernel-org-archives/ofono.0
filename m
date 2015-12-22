Content-Type: multipart/mixed; boundary="===============3178487742162256472=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Fix the ContextAdded() signal Introspection
Date: Tue, 22 Dec 2015 10:24:23 -0600
Message-ID: <56797937.4070308@gmail.com>
In-Reply-To: <1450772147-30239-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3178487742162256472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 12/22/2015 02:15 AM, John Ernberg wrote:
> From: John Ernberg <john.ernberg@actia.se>
>
> This matches the behavior described by the documentation the signal
> value returned by the code. This was causing a headache when using
> stricter D-Bus wrappers like dbus-c++.
> ---
>   src/gprs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============3178487742162256472==--

