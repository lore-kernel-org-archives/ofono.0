Content-Type: multipart/mixed; boundary="===============6529732041205677452=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test/list-modems : print Strength as an integer
Date: Thu, 16 Dec 2010 18:56:48 -0600
Message-ID: <4D0AB550.9000308@gmail.com>
In-Reply-To: <20101215150746.263810@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6529732041205677452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Benoit,

On 12/15/2010 09:07 AM, "Beno=C3=AEt Monin" wrote:
> org.ofono.NetworkRegistration property Strength is an integer,
> so print it as such.
> ---
>  test/list-modems     3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =


Patch looks fine, however it does not apply:

Applying: test/list-modems : print Strength as an integer
error: patch failed: test/list-modems:51
error: test/list-modems: patch does not apply
Patch failed at 0001 test/list-modems : print Strength as an integer

Can you make sure to configure your MTA agent correctly?

Regards,
-Denis

--===============6529732041205677452==--

