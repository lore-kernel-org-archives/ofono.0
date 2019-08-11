Content-Type: multipart/mixed; boundary="===============1480906659270634172=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Sun, 11 Aug 2019 15:37:47 +0200
Message-ID: <CAKSBH7FrgbdEf_b4RTcR1Y6PrzQX=LzXc8NrhrZLN6RChfjcRg@mail.gmail.com>
In-Reply-To: <CAA=hcWSK7P6DP=pjCg7pdUDC=Cz9=PNWJ7_u02ZJrw8u8UG3Nw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1480906659270634172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi,

On Sun, Aug 11, 2019 at 1:57 PM JH <jupiter.hce@gmail.com> wrote:
>
> More observation about the network connection, the device has two
> network interfaces, WiFi mlan0 and LTE wwan0, I think that problem is
> likely in connman, not in ofono as in some stage, the wifi IP address
> lost as well, but it came back.
>
> Why connmand contently calling to add and to del both mlan0 and wwan0
> in route table? How does the connman manage the route, dhcp to refresh
> interface IP address?

can you check with the ofono script test/list-contexts if the method
is static or dhcp?
I believe this can be the problem: if ofono managed to get an IP
address, likely with at+cgpaddr and/or at+cgcontrdp,
then it passes it to connman, and then it is set on the interface...
static, with no lease expiration.

best regards,
Giacinto

--===============1480906659270634172==--

