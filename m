Content-Type: multipart/mixed; boundary="===============1940662713000436121=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] smart-messaging: set agent to NULL after free
Date: Wed, 02 Feb 2011 13:24:47 -0600
Message-ID: <4D49AF7F.70107@gmail.com>
In-Reply-To: <1296672812-2983-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1940662713000436121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 02/02/2011 12:53 PM, Lucas De Marchi wrote:
> If agent is not set to NULL after it's freed, the following situation
> would not work:
> =

> smart_messaging_register_agent()
> smart_messaging_unregister_agent()
> smart_messaging_register_agent()
> =

> And this one could potentially crash oFono:
> =

> smart_messaging_register_agent()
> smart_messaging_unregister_agent()
> smart_messaging_unregister_agent()
> ---
>  plugins/smart-messaging.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============1940662713000436121==--

