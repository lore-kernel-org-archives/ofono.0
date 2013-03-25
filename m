Content-Type: multipart/mixed; boundary="===============8386244894813625929=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: when to set a Modem online
Date: Mon, 25 Mar 2013 15:34:24 +0100
Message-ID: <CABvLYuCcfYBrNWETbSGbWm=Mem5Mh9q4nuKYQre9tmj7C5=e3Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8386244894813625929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Huawei devices i need to wait for the pin to be entered before
setting the Online property to true.
For this i'm waiting for the Interfaces dict to contain
org.ofono.ConnectionManager.
Now i'm trying an Option dongle, the org.ofono.ConnectionManager
interface is only added after the Online property is set.

So checking which interfaces are available isn't a good way to check
when i can set a modem Online.
Is there a good way to know the modem is in MODEM_STATE_OFFLINE, and
we can set the Online property?

Thanks,
Cedric

--===============8386244894813625929==--

