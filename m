Content-Type: multipart/mixed; boundary="===============6589993516991518448=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/10] Add framework of server parser
Date: Mon, 22 Mar 2010 13:02:07 -0500
Message-ID: <201003221302.07781.denkenz@gmail.com>
In-Reply-To: <1268991888-17279-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6589993516991518448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> a. The parser fetch and parse one command per loop. The prefix is
> the command prefix without parameter. For example, the prefix of
> "AT+CLIP=3D1" is "+CLIP".
> =

> b. Search registered notification node in command_list. Invoke the
> callback if found.
> =

> c. Termiate the execution if the result is an error. Otherwise,
> parse next command.

I applied this patch but refactored it heavily afterwards.  Thanks.

Regards,
-Denis

--===============6589993516991518448==--

