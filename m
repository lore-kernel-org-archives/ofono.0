Content-Type: multipart/mixed; boundary="===============7183183157735407578=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Periodic AT commands
Date: Fri, 31 Aug 2018 10:04:18 -0500
Message-ID: <eb011945-f8da-9f3f-f512-7a2dfc99a7c4@gmail.com>
In-Reply-To: <HE1PR1001MB07959520E0073291CD45DB3E960F0@HE1PR1001MB0795.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7183183157735407578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mattias,

On 08/31/2018 04:58 AM, Mattias M=C3=A5nsson wrote:
> I would like to implement a periodic status check for our modem and =

> wonder if there is any support for this in ofono already. Some way to =

> get a periodic callback perhaps, where I could then run a few AT commands.
>

This is easily done with g_timeout_add_seconds or g_timeout_add.  See =

drivers/atmodem/voicecall.c and search for poll_clcc or so for an example.

Regards,
-Denis

--===============7183183157735407578==--

