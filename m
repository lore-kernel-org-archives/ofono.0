Content-Type: multipart/mixed; boundary="===============7940999833636027274=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugin: Don't unload external plugins too early
Date: Mon, 23 Jul 2018 19:58:15 -0500
Message-ID: <611e7102-6749-4422-f8ac-3ce3c8f4abe4@gmail.com>
In-Reply-To: <1532108123-23886-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7940999833636027274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 07/20/2018 12:35 PM, Slava Monich wrote:
> Plugins may reference data structures allocated by each other.
> They all need to be deinitialized first, only then it should be
> safe to unload the libraries.
> ---
>   src/plugin.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============7940999833636027274==--

