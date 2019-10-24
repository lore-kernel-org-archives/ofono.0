Content-Type: multipart/mixed; boundary="===============5756848874284629856=="
MIME-Version: 1.0
From: contact@dsiekmeier.de
Subject: Re: Connection lost on Embedded Linux system
Date: Thu, 24 Oct 2019 12:53:34 +0000
Message-ID: <20191024125334.2734.14466@new-ml01.vlan13.01.org>
In-Reply-To: <20191021083140.2603.65659@new-ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5756848874284629856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Okay... bit by bit I find out more information.

I removed the antenna a couple of times (~30) to force the modem to lost th=
e connection.
Mounting the antenna again I retrieve a new IP address from the cellphone c=
ompany.
oFono is showing the information in the log and the settings of the network=
 interface is
updated (checked with "ip addr").

But occasionally (in case of failing ping), the address is shown but not ap=
plied to the
interface. Therefore I wonder if it is really a oFono problem...

Kind Regards.
--===============5756848874284629856==--

