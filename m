Content-Type: multipart/mixed; boundary="===============6681004531656036302=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Make the ContextAdded return a variant.
Date: Mon, 21 Dec 2015 14:03:16 -0600
Message-ID: <56785B04.1060802@gmail.com>
In-Reply-To: <1450692676-30962-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6681004531656036302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 12/21/2015 04:10 AM, John Ernberg wrote:
> From: John Ernberg <john.ernberg@actia.se>
>
> This matches the behavior described by the documentation and the signal
> value described in the introspection. This was causing a headache when
> using stricter D-Bus wrappers like dbus-c++.
> ---
>   src/gprs.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>

Hmm, this appears to be a bug in the introspection data.  The signature =

should be:

"ContextAdded", GDBUS_ARGS({ "path", "o" }, { "properties", "a{sv}" })

similar to how MessageManager.MessageAdded is done.

Regards,
-Denis

--===============6681004531656036302==--

