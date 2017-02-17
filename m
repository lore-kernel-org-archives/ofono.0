Content-Type: multipart/mixed; boundary="===============8300649810099627892=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: huawei: modem channel gets closed after PPP disconnection
Date: Fri, 17 Feb 2017 11:15:45 -0600
Message-ID: <4a8ffc3a-6f2c-9a04-43ff-a2017fb01f8d@gmail.com>
In-Reply-To: <d8e1f630-a974-f369-ab7d-168295c10806@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8300649810099627892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,
>
> So only network interface appears (connection) and vanishes
> (disconnection).

Okay, good.

>
> So nothing more than a POLLERR|POLLHUP event on modem channel.

okay, but the socket still has to be reopened I guess due to the POLLHUP.

> If you are OK, I'll send patch next week.

Sure.

Regards,
-Denis


--===============8300649810099627892==--

