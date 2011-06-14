Content-Type: multipart/mixed; boundary="===============0820396568006910275=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PDP Context Activation
Date: Tue, 14 Jun 2011 04:35:44 -0500
Message-ID: <4DF72B70.1020201@gmail.com>
In-Reply-To: <BANLkTimqCxm3vBeTy-tyQ_R737mpogGDjA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0820396568006910275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yuvaraj,

> Control @ ste_gprs_activate_primary
>  Command is AT+CGDCONT=3D1,"IP",""
> Control @ ste_cgdcont_cb
> Control 1 @ ste_cgdcont_cb
> ofonod[8803]: src/gprs.c:pri_activate_callback() 0xa02f868 (null)
> ofonod[8803]: src/gprs.c:pri_activate_callback() Activating context
> failed with error: Unknown error type

You might try provisioning the context first since you're trying to
activate an empty APN.

See doc/connman-api.txt for more details.

Regards,
-Denis

--===============0820396568006910275==--

