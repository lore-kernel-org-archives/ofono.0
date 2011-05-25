Content-Type: multipart/mixed; boundary="===============4346844020648742599=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH V2 3/4] voicecall: save last dialed number
Date: Wed, 25 May 2011 06:19:50 -0500
Message-ID: <4DDCE5D6.5060708@gmail.com>
In-Reply-To: <1305884461-4476-4-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4346844020648742599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

<snip>

>  =

> +#define VOICECALL_STORE "voicecall"

Can you please be consistent with the rest of the code and name this
SETTINGS_STORE?

> +#define LASTDIAL_GROUP "LastDial"
> +

Same here, call this SETTINGS_GROUP and use "Settings"

Regards,
-Denis

--===============4346844020648742599==--

